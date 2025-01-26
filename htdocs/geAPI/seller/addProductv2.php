<?php
// include '../connection.php';

// //POST => send data to db

// //GET => fetch data from db

// $shop_id = $_POST['shop_id'];
// $product_name = $_POST['product_name'];
// $price = $_POST['price'];
// $quantity = $_POST['quantity'];
// $description = $_POST['description'];
// $created_at = $_POST['created_at'];
// $updated_at = $_POST['updated_at'];
// $status = $_POST['status'];
// $category = $_POST['category'];
// $image_file = $_POST['image_file'];
// $distance = $_POST['distance'];
// $avg_rating = $_POST['avg_rating'];

// // // Use a default placeholder for image_file
// // $image_file = isset($_POST['image_file']) ? $_POST['image_file'] : file_get_contents('path/to/default-placeholder.jpg');
// // $image_file = addslashes($image_file); // Escape special characters for SQL


// $sqlQuery = "INSERT INTO product SET shop_id = '$shop_id', product_name = '$product_name', `price` = '$price', quantity = '$quantity', `description` = '$description', created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP, `status` = '$status', category = '$category', image_file = 'test', distance = '$distance', avg_rating = '$avg_rating'";

// $resultQuery = $connectNow->query($sqlQuery);

// if($resultQuery)
// {
//     $shop_id = $connectNow->insert_id;
//     echo json_encode(array("addProdSuccessful"=>true, "shop_id"=>$shop_id));
// }
// else
// {
//     echo json_encode(array("addProdSuccessful"=>false, "error" => $connectNow->error));
//} 


include '../connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $shop_id = $_POST['shop_id'];
    $product_name = $_POST['product_name'];
    $price = $_POST['price'];
    $quantity = $_POST['quantity'];
    $description = $_POST['description'];
    $status = $_POST['status'];
    $category = $_POST['category'];
    $distance = $_POST['distance'];
    $avg_rating = $_POST['avg_rating'];

    // Directory to store uploaded images
    $uploadDir = __DIR__ . '/uploads/';

    // Ensure the uploads directory exists
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }

    // Handle the image file
    $imageFilePath = 'default-placeholder.jpg'; // Default image
    if (isset($_FILES['image_file']) && $_FILES['image_file']['error'] === UPLOAD_ERR_OK) {
        $imageFileName = basename($_FILES['image_file']['name']);
        $imageFilePath = 'uploads/' . $imageFileName; // Relative path for DB
        $fullImagePath = $uploadDir . $imageFileName; // Absolute path for saving

        if (!move_uploaded_file($_FILES['image_file']['tmp_name'], $fullImagePath)) {
            echo json_encode(["addProdSuccessful" => false, "error" => "Failed to save image."]);
            exit;
        }
    }

    // Insert the product into the database
    $sqlQuery = "INSERT INTO product 
                 SET shop_id = '$shop_id', 
                     product_name = '$product_name', 
                     price = '$price', 
                     quantity = '$quantity', 
                     description = '$description', 
                     created_at = CURRENT_TIMESTAMP, 
                     updated_at = CURRENT_TIMESTAMP, 
                     status = '$status', 
                     category = '$category', 
                     image_file = '$imageFilePath', 
                     distance = '$distance', 
                     avg_rating = '$avg_rating'";

    $resultQuery = $connectNow->query($sqlQuery);

    if ($resultQuery) {
        $product_id = $connectNow->insert_id;
        echo json_encode(["addProdSuccessful" => true, "product_id" => $product_id, "image_path" => $imageFilePath]);
    } else {
        echo json_encode(["addProdSuccessful" => false, "error" => $connectNow->error]);
    }
} else {
    echo json_encode(["addProdSuccessful" => false, "error" => "Invalid request method."]);
}
?>
