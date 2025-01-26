<?php

include '../connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['user_id'])) {
    $user_id = $_GET['user_id'];

    // Query to fetch shop details based on user_id
    $sqlQuery = "SELECT * FROM shop WHERE user_id = '$user_id'";
    $result = $connectNow->query($sqlQuery);

    if ($result->num_rows > 0) {
        $shop = array();
        while ($row = $result->fetch_assoc()) {
            $shop[] = $row;
        }
        echo json_encode(array("success" => true, "shop" => $shop));
    } else {
        echo json_encode(array("success" => false, "message" => "No shop found for the given user_id."));
    }
} else {
    echo json_encode(array("success" => false, "message" => "Invalid request or missing user_id."));
}
