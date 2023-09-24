<?php 
require_once("db.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css"> <!-- Link to your CSS file -->
    <title>NIC Landing Page</title>
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
        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            background-color: #333;
            overflow: hidden;
        }
        nav li {
            float: left;
        }
        nav a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }
        nav a:hover {
            background-color: #0044cc;
        }
        main {
            text-align: center;
            padding: 20px;
        }
        button#apply-now-button {
            background-color: #0080ff;
            color: white;
            padding: 15px 30px;
            font-size: 18px;
            border: none;
            cursor: pointer;
        }
        button#apply-now-button:hover {
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
    <nav>
        <ul>
            <li><a href="#how-to-apply">How to Apply</a></li>
            <li><a href="#application-fee-details">Application Fee Details</a></li>
            <li><a href="#downloads">Downloads</a></li>
            <li><a href="#track-nic-status">Track NIC Status</a></li>
            <li><a href="#services">Services</a></li>
            <li><a href="#legal-background">Legal Background</a></li>
            <li><a href="#faq">FAQ</a></li>
            <li><a href="#contact-us">Contact Us</a></li>
        </ul>
    </nav>
    <main>
    <a href="login.php">
        <button id="apply-now-button">Apply Now</button>
    </a>
</main>

    <footer>
        &copy; 2023 NIC. All rights reserved.
    </footer>
</body>
</html>
