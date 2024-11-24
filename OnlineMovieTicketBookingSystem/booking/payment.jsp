<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // Fetch parameters from the request
    String movieId = request.getParameter("movieId");
    String userId = request.getParameter("userId");
    String seats = request.getParameter("seats");

    // Check for missing or invalid parameters
    boolean invalidParams = false;
    StringBuilder errorMsg = new StringBuilder();

    if (movieId == null || movieId.isEmpty()) {
        invalidParams = true;
        errorMsg.append("Movie ID is missing or invalid.<br>");
    }
    if (userId == null || userId.isEmpty()) {
        invalidParams = true;
        errorMsg.append("User ID is missing or invalid.<br>");
    }
    if (seats == null || seats.isEmpty() || Integer.parseInt(seats) <= 0) {
        invalidParams = true;
        errorMsg.append("Seats value is missing, invalid, or less than 1.<br>");
    }

    if (invalidParams) {
%>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8d7da;
            color: #721c24;
            text-align: center;
            padding: 50px;
        }
        h1 {
            font-size: 36px;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            margin-bottom: 20px;
        }
        a {
            font-size: 16px;
            color: #0056b3;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>Error</h1>
    <p>The following issues were found:</p>
    <p><%= errorMsg.toString() %></p>
    <a href="../index.jsp">Back to Home</a>
</body>
</html>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('../images/tollywood-background.jpg');
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
        body::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.6);
            z-index: -1;
        }
        .container {
            background-color: rgba(0, 0, 0, 0.7);
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
        }
        p {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .amount {
            font-size: 24px;
            color: #f4f4f9;
            margin-bottom: 20px;
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
    </style>
</head>
<body>
    <div class="container">
        <h1>Payment for Movie</h1>
        <p>Movie ID: <%= movieId %></p>
        <p>User ID: <%= userId %></p>
        <p>Number of Seats: <%= seats %></p>
        <%
            int totalAmount = Integer.parseInt(seats) * 150; // Assuming ₹150 per seat
        %>
        <p class="amount">Total Amount: ₹<%= totalAmount %></p>

        <form action="bookingSuccess.jsp" method="post">
            <input type="hidden" name="movieId" value="<%= movieId %>">
            <input type="hidden" name="userId" value="<%= userId %>">
            <input type="hidden" name="seats" value="<%= seats %>">
            <input type="hidden" name="amountPaid" value="<%= totalAmount %>">
            <button type="submit">Confirm Payment</button>
        </form>
    </div>
</body>
</html>
