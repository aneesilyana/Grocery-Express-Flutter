<?php

include '../connection.php';

$shop_name = $_POST['shop_name'];

$sqlQuery = "SELECT * FROM shop WHERE shop_name='$shop_name'";

$resultQuery = $connectNow->query($sqlQuery);

if($resultQuery->num_rows > 0)
{
   echo json_encode(array("nameFound"=>true));
}
else
{
    echo json_encode(array("nameFound"=>false));
}