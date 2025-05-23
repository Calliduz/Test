<?php
// CORS and JSON headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// Debug safely: show PHP warnings if needed
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);

// DB connection
require_once "db.php";

// Clean output buffer to remove extra whitespace or BOM
ob_clean();

// FETCH MAIN CATEGORIES
$mainQuery = "SELECT * FROM categories";
$mainResult = $conn->query($mainQuery);

$structured = [];

while ($cat = $mainResult->fetch_assoc()) {
    $structured[$cat['name']] = [
        "label" => $cat['label'],
        "subcategories" => []
    ];
}

// FETCH SUBCATEGORIES
$subQuery = "SELECT * FROM subcategories";
$subResult = $conn->query($subQuery);

$subcategories = [];
while ($sub = $subResult->fetch_assoc()) {
    $mainId = $sub['category_id'];
    $mainNameQuery = "SELECT name FROM categories WHERE id = $mainId";
    $mainNameRes = $conn->query($mainNameQuery);
    $mainNameRow = $mainNameRes->fetch_assoc();
    $mainName = $mainNameRow['name'];

    $subcategories[$sub['id']] = $sub['name'];

    $structured[$mainName]["subcategories"][$sub['name']] = [
        "label" => $sub['label'],
        "unit" => $sub['unit'],
        "predefinedItems" => []
    ];
}

// FETCH PREDEFINED ITEMS
$itemQuery = "SELECT * FROM predefined_items";
$itemResult = $conn->query($itemQuery);

while ($item = $itemResult->fetch_assoc()) {
    $subId = $item['subcat_id'];
    $mainId = $item['main_category_id'];

    if (isset($subcategories[$subId])) {
        $subName = $subcategories[$subId];
        $mainNameQuery = "SELECT name FROM categories WHERE id = $mainId";
        $mainNameRes = $conn->query($mainNameQuery);
        $mainNameRow = $mainNameRes->fetch_assoc();
        $mainName = $mainNameRow['name'];

        $structured[$mainName]["subcategories"][$subName]["predefinedItems"][] = [
            "name" => $item['name'],
            "unit" => $item['unit']
        ];
    }
}

// Output clean JSON
echo json_encode($structured, JSON_PRETTY_PRINT);

// END CLEANLY
exit;
