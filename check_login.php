<?php
// Include your database connection file if not already included
require_once("db.php"); // Ensure this includes your database connection file


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Query the database to retrieve the hashed password for the provided email
    $query = "SELECT email, password FROM users WHERE email = '$email'";
    $result = mysqli_query($connection, $query);

    if ($result && mysqli_num_rows($result) === 1) {
        $row = mysqli_fetch_assoc($result);
        $hashedPassword = $row['password'];
    
        if (password_verify($password, $hashedPassword)) {
            // Password is correct; you can proceed with user authentication
            
            // Redirect to form.php upon successful login
            header("Location: form.php");
            exit(); // Make sure to exit to prevent further script execution
        } else {
            // Password is incorrect
            echo 'error: Incorrect password';
        }
    } else {
        // User with the provided email does not exist in the database
        echo 'error: User not found';
    }
}

    


?>
