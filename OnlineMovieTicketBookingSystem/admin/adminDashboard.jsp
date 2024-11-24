<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        /* General body and text styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        /* Header styling */
        h1 {
            text-align: center;
            margin-top: 50px;
            color: #333;
        }

        /* Container for the main dashboard content */
        .dashboard-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }

        /* Styling for navigation links */
        .dashboard-container a {
            display: block;
            width: 100%;
            text-align: center;
            margin: 15px 0;
            padding: 15px;
            font-size: 18px;
            color: white;
            background-color: #4CAF50;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        /* Hover effect for links */
        .dashboard-container a:hover {
            background-color: #45a049;
        }

        /* Error message styling */
        .error {
            color: red;
            font-size: 16px;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <h1>Admin Dashboard</h1>

    <div class="dashboard-container">
        <!-- Navigation links to manage movies -->
        <a href="manageMovies.jsp">Manage Movies</a>
        
        <!-- Additional links can be added here if required -->
        <!-- <a href="anotherPage.jsp">Another Page</a> -->
    </div>

    <%
        // Example error message handling, if any issues like invalid session or permission, it can be shown here
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
    <div class="error"><%= errorMessage %></div>
    <% 
        }
    %>
    
</body>
</html>
