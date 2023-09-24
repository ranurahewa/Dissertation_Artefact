<?php
require_once("db.php");

if(isset($_POST['sub_btn'])){
    $username=mysqli_real_escape_string($connection,$_POST['username']);
    $email=mysqli_real_escape_string($connection,$_POST['email']);
    $password=$_POST['password'];

    // Hash the password before storing it
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
    
    if(mysqli_query($connection,"INSERT INTO users (username, email, password) VALUES ('$username', '$email', '$hashedPassword')")){
        header("location:login.php?added_success");
    }  
}
  

?>
