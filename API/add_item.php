<?php
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include_once 'db.php';

// Get raw data and decode
$raw_data = file_get_contents("php://input");
error_log("Received raw data: " . $raw_data);

// Ensure we have data
if (empty($raw_data)) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => 'No data received'
    ]);
    exit();
}

$data = json_decode($raw_data, true);
error_log("Decoded data: " . print_r($data, true));

// Validate required fields
if (!isset($data['predefined_item_id'], $data['quantity'])) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => 'Missing required fields',
        'received' => $data
    ]);
    exit();
}

try {
    $conn->begin_transaction();

    $created_at = date('Y-m-d H:i:s');
    $harvest_date = !empty($data['harvest_date']) ? $data['harvest_date'] : null;
    
    // Insert into items table
    $stmt = $conn->prepare("INSERT INTO items (predefined_item_id, quantity, created_at, updated_at) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("iiss", $data['predefined_item_id'], $data['quantity'], $created_at, $created_at);
    
    if (!$stmt->execute()) {
        throw new Exception("Failed to add item: " . $stmt->error);
    }
    
    $item_id = $conn->insert_id;

    // Insert into item_history with harvest_date
    $history_stmt = $conn->prepare("INSERT INTO item_history (predefined_item_id, quantity, harvest_date, notes, change_type, date) VALUES (?, ?, ?, ?, 'add', ?)");
    $notes = $data['notes'] ?? '';
    $history_stmt->bind_param("iisss", $data['predefined_item_id'], $data['quantity'], $harvest_date, $notes, $created_at);

    if (!$history_stmt->execute()) {
        throw new Exception("Failed to add history: " . $history_stmt->error);
    }

    $conn->commit();
    
    echo json_encode([
        'success' => true,
        'message' => 'Item added successfully',
        'id' => $item_id
    ]);

} catch (Exception $e) {
    $conn->rollback();
    error_log("Error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}

$conn->close();
?>