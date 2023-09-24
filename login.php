<?php 
require_once("db.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css"> <!-- Link to your CSS file -->
    <title>NIC Account</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7;
        }
        header {
            background-color: #0080ff;
            color: white;
            padding: 20px;
            text-align: center;
        }
        main {
            text-align: center;
            padding: 50px 0;
        }
        button {
            background-color: #0080ff;
            color: white;
            padding: 15px 30px;
            font-size: 18px;
            border: none;
            cursor: pointer;
            margin: 10px;
            border-radius: 5px;
        }
        button:hover {
            background-color: #0044cc;
        }
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px;
        }
    </style>
</head>
<body>
    <header>
        <h1>Department for the Registration of Persons</h1>
    </header>
    <main>
        <a href="signup.php"> <button id="register-button">Register an Account</button></a>
        <a href="signin.php"><button id="login-button">Login with Existing Account</button></a>
    </main>
    <footer>
        &copy; 2023 NIC. All rights reserved.
    </footer>
</body>
</html>
