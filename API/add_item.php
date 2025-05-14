<?php
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Credentials: true");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include_once 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

if (
    isset($data['predefined_item_id'], $data['quantity'], $data['harvest_date'])
) {
    $created_at = date('Y-m-d H:i:s');
    $updated_at = $created_at;

    $stmt = $conn->prepare("INSERT INTO items (predefined_item_id, quantity, harvest_date, created_at, updated_at) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param(
        "iisss",
        $data['predefined_item_id'],
        $data['quantity'],
        $data['harvest_date'],
        $created_at,
        $updated_at
    );

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Item added successfully']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to add item', 'error' => $stmt->error]);
    }

    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Missing data']);
}

$conn->close();
?>