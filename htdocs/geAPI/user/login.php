<?php
include '../connection.php';

//POST => send data to db

//GET => fetch data from db

$email = $_POST['email'];
$password = $_POST['password'];

$sqlQuery = "SELECT * FROM user WHERE email = '$email' AND `password` = '$password'";

$resultQuery = $connectNow->query($sqlQuery);

if($resultQuery->num_rows > 0)
{
    $userRecord = array();
    while($rowFound = $resultQuery->fetch_assoc())
    {
        $userRecord[] = $rowFound;
    }

    echo json_encode(
        array(
            "loginSuccessful"=>true,
            "userData"=>$userRecord[0],
        )
    );
} 
else
{
    echo json_encode(array("loginSuccessful"=>false));
}