<?php
include '../connection.php';

//POST => send data to db

//GET => fetch data from db

$prod_name = $_POST['prod_name'];
$price = $_POST['price'];
$description = ($_POST['description']);
$distance = $_POST['distance'];
$rating = $_POST['rating'];
$shop_name = $_POST['shop_name'];
$category = $_POST['category'];
$image_file = $_POST['image_file'];
$shop_id = $_POST['shop_id'];


$sqlQuery = "INSERT INTO product SET prod_name = '$prod_name', price = '$price', description = '$description', distance = '$distance', rating = '$rating', shop_name = '$shop_name', category = '$category', image_file = 'test', shop_id = 'S001'";

$resultQuery = $connectNow->query($sqlQuery);

if($resultQuery)
{
    echo json_encode(array("prodAddSuccessful"=>true));
}
else
{
    echo json_encode(array("prodAddSuccessful"=>false));
} 