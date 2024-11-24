<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Online Movie Ticket Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('images/home.jpg'); /* Path to your Tollywood background image */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: #333;
            margin: 0;
            padding: 0;
        }

        /* Optional overlay to darken the background for better readability */
        body::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5); /* Black overlay with transparency */
            z-index: -1;
        }

        header {
            background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent background for header */
            color: #fff;
            text-align: center;
            padding: 20px 0;
        }

        h1 {
            margin: 0;
            font-size: 36px;
        }

        .content {
            text-align: center;
            margin-top: 50px;
        }

        .content a {
            text-decoration: none;
            font-size: 18px;
            color: #fff;
            background-color: #007bff;
            padding: 12px 25px;
            margin: 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .content a:hover {
            background-color: #0056b3;
        }

        footer {
            text-align: center;
            padding: 20px;
            background-color: #333;
            color: #fff;
            position: fixed;
            width: 100%;
            bottom: 0;
        }
    </style>
</head>
<body>
    <header>
        <h1>Welcome to Online Movie Ticket Booking</h1>
    </header>

    <div class="content">
        <a href="movies/movieList.jsp">View Movies</a> |
        <a href="admin/login.jsp">Admin Login</a>
    </div>

    <footer>
        <p>&copy; 2024 Online Movie Ticket Booking</p>
    </footer>
</body>
</html>
