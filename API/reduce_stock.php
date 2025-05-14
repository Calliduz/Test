<?php
// filepath: c:\xampp\htdocs\Test\API\reduce_stock.php

header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Credentials: true");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
include 'db.php';

if (!$conn) {
    echo json_encode(["success" => false, "message" => "Database connection failed"]);
    exit;
}

// Retrieve and decode the JSON payload
$rawInput = file_get_contents("php://input");
error_log("Raw input received: " . $rawInput); // Debug log
$data = json_decode($rawInput, true);

if (json_last_error() !== JSON_ERROR_NONE) {
    error_log("JSON decoding error: " . json_last_error_msg()); // Debug log
    echo json_encode(["success" => false, "message" => "Invalid JSON payload"]);
    exit;
}

// Extract data from the payload
$itemId = $data['itemId'] ?? null;
$quantity = $data['quantity'] ?? null;
$notes = $data['notes'] ?? 'Stock reduced';
$userId = $data['userId'] ?? null;

if (!$userId) {
    echo json_encode(["success" => false, "message" => "User ID is required"]);
    exit;
}

if (!$itemId || !$quantity) {
    echo json_encode(["success" => false, "message" => "Item ID and quantity are required"]);
    exit;
}

// Fetch predefined_item_id from the items table
$predefinedItemIdQuery = "SELECT predefined_item_id FROM items WHERE id = ?";
$stmt = $conn->prepare($predefinedItemIdQuery);
$stmt->bind_param("i", $itemId);
$stmt->execute();
$result = $stmt->get_result();
if ($row = $result->fetch_assoc()) {
    $predefinedItemId = $row['predefined_item_id'];
} else {
    echo json_encode(["success" => false, "message" => "Item not found"]);
    exit;
}

// Update the items table
$updateItemQuery = "UPDATE items SET quantity = quantity + ? WHERE id = ?";
$stmt = $conn->prepare($updateItemQuery);
$stmt->bind_param("ii", $quantity, $itemId);
$stmt->execute();

if ($stmt->affected_rows === 0) {
    echo json_encode(["success" => false, "message" => "Failed to update item quantity"]);
    exit;
}

// Insert into item_history table
$insertHistoryQuery = "INSERT INTO item_history (predefined_item_id, quantity, notes, change_type, date, harvest_date) 
                      VALUES (?, ?, ?, 'reduce', NOW(), NULL)";
$stmt = $conn->prepare($insertHistoryQuery);
$stmt->bind_param("iis", $predefinedItemId, $quantity, $notes);
$stmt->execute();
// Insert into action_logs table
$insertLogQuery = "INSERT INTO action_logs (user_id, action_type, description, timestamp) 
                  VALUES (?, 'reduce_stock', ?, NOW())";
$logDescription = "Reduced stock for item ID: $itemId by $quantity units.";
$stmt = $conn->prepare($insertLogQuery);
$stmt->bind_param("is", $userId, $logDescription);
$stmt->execute();

echo json_encode(["success" => true, "message" => "Stock reduced and logged successfully"]);
?>