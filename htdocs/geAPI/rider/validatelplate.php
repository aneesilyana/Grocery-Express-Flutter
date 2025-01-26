<?php

include '../connection.php';

$license_plate = $_POST['license_plate'];

$sqlQuery = "SELECT * FROM rider WHERE license_plate='$license_plate'";

$resultQuery = $connectNow->query($sqlQuery);

if($resultQuery->num_rows > 0)
{
   echo json_encode(array("plateFound"=>true));
}
else
{
    echo json_encode(array("plateFound"=>false));
}