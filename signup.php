<?php 
require_once("db.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css"> <!-- Link to your CSS file -->
    <title>User Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .form-container {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0px 0px 10px 0px #000000;
            padding: 20px;
            width: 300px;
        }
        header {
            background-color: #0080ff;
            color: white;
            text-align: center;
            padding: 20px;
            margin-bottom: 20px;
        }
        form {
            text-align: left;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box; /* Add this property */
        }
        button[type="submit"] {
            background-color: #0080ff;
            color: white;
            padding: 15px 30px;
            font-size: 18px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
        }
        button[type="submit"]:hover {
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
        <h1>User Registration</h1>
    </header>
    <div class="container">
        <div class="form-container">
            <form action="process.php" method="POST">
                <label for="username">Name:</label>
                <input type="text" id="username" name="username" required>
                
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                
                <a href ="login.php"><button type="submit" name="sub_btn">Register<button></a>
            </form>
        </div>
    </div>
    <footer>
        &copy; 2023 Your Company. All rights reserved.
    </footer>
</body>
</html>
