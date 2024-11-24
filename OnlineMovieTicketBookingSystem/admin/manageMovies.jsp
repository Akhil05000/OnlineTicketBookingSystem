<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DbConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Movies - Admin Dashboard</title>
    <link rel="stylesheet" href="../styles/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            margin: 5px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .form-container {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>Manage Movies</h1>
    
    <!-- Button to Add New Movie -->
    <div class="form-container">
        <a href="addMovie.jsp" class="btn">Add New Movie</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Release Date</th>
                <th>Duration (mins)</th>
                <th>Genre</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Connect to database and fetch movie records
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DbConnection.getConnection();
                    stmt = conn.createStatement();
                    String query = "SELECT * FROM movies";
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int movieId = rs.getInt("movie_id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        Date releaseDate = rs.getDate("release_date");
                        int duration = rs.getInt("duration");
                        String genre = rs.getString("genre");
            %>
            <tr>
                <td><%= title %></td>
                <td><%= description %></td>
                <td><%= releaseDate %></td>
                <td><%= duration %></td>
                <td><%= genre %></td>
                <td>
                    <!-- Removed the Edit button -->
                    <a href="deleteMovie.jsp?id=<%= movieId %>" class="btn" style="background-color: #f44336;">Delete</a>
                </td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p style='color: red;'>Error fetching movie data.</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>
</body>
</html>
