<?php

include '../connection.php';

$email = $_POST['email'];

$sqlQuery = "SELECT * FROM user WHERE email='$email'";

$resultQuery = $connectNow->query($sqlQuery);

if($resultQuery->num_rows > 0)
{
   echo json_encode(array("emailFound"=>true));
}
else
{
    echo json_encode(array("emailFound"=>false));
}