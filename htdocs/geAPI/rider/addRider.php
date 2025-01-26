<?php

include '../connection.php'; // Include database connection

// Fetch data from POST request and assign default values where necessary
$user_id = $_POST['user_id'];
$vehicle_type = $_POST['vehicle_type'];
$license_plate = $_POST['license_plate'];
$availability = $_POST['availability'];
//$assigned_order_id = isset($_POST['assigned_order_id']) ? $_POST['assigned_order_id'] : null; // Nullable
$created_at = $_POST['created_at'];
$updated_at = $_POST['updated_at'];

// SQL query to insert rider data
//$sqlQuery = "INSERT INTO rider (user_id, vehicle_type, license_plate, availability, assigned_order_id, created_at, updated_at)
//VALUES ('$user_id', '$vehicle_type', '$license_plate', '$availability', '$assigned_order_id', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";

$sqlQuery = "INSERT INTO rider SET user_id = '$user_id', vehicle_type = '$vehicle_type', license_plate = '$license_plate', availability = '$availability', assigned_order_id = NULL, created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP";

$resultQuery = $connectNow->query($sqlQuery);

// Response back to the client
if ($resultQuery) {
    echo json_encode(array("riderAddSuccessful" => true));
} else {
    echo json_encode(array("riderAddSuccessful" => false, "error" => $connectNow->error));
}
?>
