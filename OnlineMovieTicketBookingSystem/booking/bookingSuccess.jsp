<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="utils.DbConnection" %>
<%
    // Fetch parameters from the request
    String movieId = request.getParameter("movieId");
    String seats = request.getParameter("seats");
    String userId = request.getParameter("userId");
    String amountPaid = request.getParameter("amountPaid");

    // Check for missing or invalid parameters
    if (movieId == null || seats == null || userId == null || amountPaid == null || 
        movieId.isEmpty() || seats.isEmpty() || userId.isEmpty() || amountPaid.isEmpty()) {
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
    <p>Required parameters are missing or invalid.</p>
    <a href="../index.jsp">Back to Home</a>
</body>
</html>
<%
    } else {
        // Database booking logic
        Connection con = null;
        PreparedStatement pst = null;

        try {
            con = DbConnection.getConnection();
            String query = "INSERT INTO bookings (movie_id, user_id, seats, show_time) VALUES (?, ?, ?, NOW())";
            pst = con.prepareStatement(query);
            pst.setInt(1, Integer.parseInt(movieId));
            pst.setInt(2, Integer.parseInt(userId));
            pst.setInt(3, Integer.parseInt(seats));
            pst.executeUpdate();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #d4edda;
            color: #155724;
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
        .btn {
            font-size: 18px;
            color: white;
            background-color: #28a745;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <h1>Booking Confirmed!</h1>
    <p>Thank you for your payment! Your booking for Movie ID <%= movieId %> has been successfully processed.</p>
    <p>You have booked <%= seats %> seat(s).</p>
    <a href="../index.jsp" class="btn">Back to Home</a>
</body>
</html>
<%
        } catch (SQLException e) {
            // Capture stack trace as a String
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
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
        pre {
            font-size: 14px;
            background-color: #fff3cd;
            color: #856404;
            padding: 15px;
            border-radius: 5px;
            text-align: left;
            white-space: pre-wrap;
            word-wrap: break-word;
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
    <p>Something went wrong while processing your booking. Please try again later.</p>
    <pre><%= sw.toString() %></pre>
    <a href="../index.jsp">Back to Home</a>
</body>
</html>
<%
        } finally {
            if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }
    }
%>
