<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String movieId = request.getParameter("movieId");
    String userId = "1"; // Assume logged-in user
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Ticket</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('../images/tollywood-background.jpg'); /* Path to your Tollywood background image */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: #fff;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Overlay to darken the background */
        body::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.6); /* Semi-transparent black overlay */
            z-index: -1;
        }

        .container {
            background-color: rgba(0, 0, 0, 0.7); /* Dark background for content */
            border-radius: 8px;
            padding: 40px;
            width: 80%;
            max-width: 500px;
            text-align: center;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
        }

        h1 {
            font-size: 36px;
            margin-bottom: 30px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
        }

        label {
            font-size: 18px;
            margin-bottom: 10px;
            display: block;
        }

        input[type="number"] {
            font-size: 16px;
            padding: 10px;
            margin-bottom: 20px;
            width: 100%;
            border-radius: 5px;
            border: 2px solid #007bff;
            background-color: #f4f4f4;
            color: #333;
            transition: border-color 0.3s ease;
        }

        input[type="number"]:focus {
            border-color: #0056b3;
            background-color: #fff;
        }

        button {
            font-size: 18px;
            color: white;
            background-color: #007bff;
            border: none;
            padding: 12px 25px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
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
    <div class="container">
        <h1>Book Ticket</h1>
        <form action="payment.jsp" method="post">
            <input type="hidden" name="movieId" value="<%= movieId %>">
            <input type="hidden" name="userId" value="<%= userId %>">
            
            <label for="seats">Number of Seats:</label>
            <input type="number" id="seats" name="seats" min="1" required>

            <button type="submit">Proceed to Payment</button>
        </form>
    </div>

    <footer>
        <p>&copy; 2024 Online Movie Ticket Booking</p>
    </footer>
</body>
</html>
