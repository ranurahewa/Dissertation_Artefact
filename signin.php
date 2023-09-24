<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Sign-In</title>
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
            box-sizing: border-box;
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
        <h1>User Sign-In</h1>
    </header>
    <div class="container">
        <div class="form-container">
            <form action="check_login.php" method="POST">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                
                <button type="submit" name="login_btn">Sign In</button>
            </form>
            <div class="links">
                <a href="forgot_password.php">Forgot Password?</a> | <a href="signup.php?prefill=true">Create New Account</a>
            </div>
        </div>
    </div>
    <footer>
        &copy; 2023 Your Company Name
    </footer>
</body>
</html>
