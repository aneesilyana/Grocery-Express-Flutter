<?php
include '../connection.php';

// Get user_id from the request
$user_id = $_POST['user_id'];

// Query to check if shop_id exists for the given user_id
$sqlQuery = "SELECT shop_id FROM shop WHERE user_id = '$user_id'";

$resultQuery = $connectNow->query($sqlQuery);

if ($resultQuery->num_rows > 0) {
    $shopRecord = $resultQuery->fetch_assoc();

    echo json_encode(array(
        "shopExists" => true,
        "shop_id" => $shopRecord['shop_id']
    ));
} else {
    echo json_encode(array(
        "shopExists" => false
    ));
}
?>
