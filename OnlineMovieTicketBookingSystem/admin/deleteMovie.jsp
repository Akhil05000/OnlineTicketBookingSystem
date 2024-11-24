<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DbConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Movie</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
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
        .error {
            color: red;
            text-align: center;
        }
        .success {
            color: green;
            text-align: center;
        }
    </style>
</head>
<body>

<%
    String movieId = request.getParameter("id");
    if (movieId != null && !movieId.isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            // Establish connection to the database
            conn = DbConnection.getConnection();

            // Create SQL query to delete the movie
            String query = "DELETE FROM movies WHERE movie_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(movieId));

            int result = pstmt.executeUpdate();

            if (result > 0) {
%>
                <p class="success">Movie with ID <%= movieId %> has been successfully deleted.</p>
                <a href="manageMovies.jsp" class="btn">Go Back to Manage Movies</a>
<%
            } else {
%>
                <p class="error">Error deleting movie. Movie with ID <%= movieId %> does not exist.</p>
                <a href="manageMovies.jsp" class="btn">Go Back to Manage Movies</a>
<%
            }
        } catch (SQLException e) {
            e.printStackTrace();
%>
            <p class="error">Error occurred while deleting the movie. Please try again later.</p>
            <a href="manageMovies.jsp" class="btn">Go Back to Manage Movies</a>
<%
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
%>
        <p class="error">Invalid movie ID.</p>
        <a href="manageMovies.jsp" class="btn">Go Back to Manage Movies</a>
<%
    }
%>

</body>
</html>
