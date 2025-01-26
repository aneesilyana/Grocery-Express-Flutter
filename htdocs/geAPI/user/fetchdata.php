<?php
include '../connection.php';

$sqlQuery = "SELECT 
    product.*,
    shop.shop_name
FROM 
    product
JOIN 
    shop ON product.shop_id = shop.shop_id;";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    $products = array();
    while ($row = $result->fetch_assoc()) {
        $products[] = $row;
    }
    echo json_encode(array("success" => true, "products" => $products));
} else {
    echo json_encode(array("success" => false, "message" => "No products found."));
}
?>
