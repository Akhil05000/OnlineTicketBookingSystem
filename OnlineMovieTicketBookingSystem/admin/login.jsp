<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DbConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Online Movie Ticket Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('../images/tollywood-background.jpg'); /* Path to your Tollywood background image */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: #333;
            margin: 0;
            padding: 0;
        }

        /* Overlay to darken the background */
        body::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5); /* Semi-transparent black overlay */
            z-index: -1;
        }

        .container {
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.8); /* White background with transparency */
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 8px;
            text-align: left;
            color: #333;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        .error-message {
            color: red;
            margin-top: 15px;
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
        <h2>Login</h2>
        <form method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>
            <label for="role">Role:</label>
            <select name="role" id="role">
                <option value="admin">Admin</option>
                <option value="user">User</option>
            </select><br>
            <button type="submit">Login</button>
        </form>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    // Establish database connection
                    conn = DbConnection.getConnection();

                    // Query to validate user credentials
                    String query = "SELECT * FROM users WHERE username = ? AND password = MD5(?) AND role = ?";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, username);
                    stmt.setString(2, password);
                    stmt.setString(3, role);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        // Redirect based on user role
                        if ("admin".equals(role)) {
                            response.sendRedirect("adminDashboard.jsp");
                        } else if ("user".equals(role)) {
                            response.sendRedirect("../movies/movieList.jsp");
                        }
                    } else {
                        // Display error message for invalid login
                        out.println("<p class='error-message'>Invalid credentials or role. Please try again.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p class='error-message'>An error occurred. Please try again later.</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>

    <footer>
        <p>&copy; 2024 Online Movie Ticket Booking</p>
    </footer>
</body>
</html>
