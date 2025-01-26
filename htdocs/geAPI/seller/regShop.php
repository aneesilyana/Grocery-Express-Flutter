<?php
include '../connection.php';

//POST => send data to db

//GET => fetch data from db

$user_id = $_POST['user_id'];
$shop_name = $_POST['shop_name'];
$description = $_POST['description'];
$created_at = $_POST['created_at'];
$updated_at = $_POST['updated_at'];
$status = $_POST['status'];
$contact_info = ($_POST['contact_info']);
$location = $_POST['location'];


$sqlQuery = "INSERT INTO shop SET user_id = '$user_id', shop_name = '$shop_name', `location` = '$location', contact_info = '$contact_info', `description` = '$description', `status` = '$status', created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP";

$resultQuery = $connectNow->query($sqlQuery);

if($resultQuery)
{
    $shop_id = $connectNow->insert_id;
    echo json_encode(array("regShopSuccessful"=>true, "shop_id"=>$shop_id));
}
else
{
    echo json_encode(array("regShopSuccessful"=>false, "error" => $connectNow->error));
} 