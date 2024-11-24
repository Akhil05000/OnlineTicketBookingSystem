<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DbConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Movie - Admin Dashboard</title>
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
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .form-container label {
            display: block;
            margin: 10px 0 5px;
        }
        .form-container input, .form-container textarea, .form-container select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .form-container button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            width: 100%;
            cursor: pointer;
        }
        .form-container button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <h1>Add New Movie</h1>
    
    <div class="form-container">
        <form action="addMovie.jsp" method="post">
            <!-- Display error message if any -->
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
            <div class="error"><%= errorMessage %></div>
            <% 
                }
            %>

            <!-- Movie Details Form -->
            <label for="title">Movie Title:</label>
            <input type="text" id="title" name="title" required>

            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="4" required></textarea>

            <label for="releaseDate">Release Date:</label>
            <input type="date" id="releaseDate" name="releaseDate" required>

            <label for="duration">Duration (in minutes):</label>
            <input type="number" id="duration" name="duration" min="1" required>

            <label for="genre">Genre:</label>
            <select id="genre" name="genre" required>
                <option value="Action">Action</option>
                <option value="Comedy">Comedy</option>
                <option value="Drama">Drama</option>
                <option value="Horror">Horror</option>
                <option value="Romance">Romance</option>
                <option value="Thriller">Thriller</option>
                <option value="Sci-Fi">Sci-Fi</option>
                <option value="Fantasy">Fantasy</option>
            </select>

            <button type="submit">Add Movie</button>
        </form>
    </div>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Get form data
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String releaseDate = request.getParameter("releaseDate");
            String duration = request.getParameter("duration");
            String genre = request.getParameter("genre");

            // Validate form data
            if (title == null || title.isEmpty() || description == null || description.isEmpty() ||
                releaseDate == null || releaseDate.isEmpty() || duration == null || duration.isEmpty() ||
                genre == null || genre.isEmpty()) {
                request.setAttribute("errorMessage", "All fields are required.");
                request.getRequestDispatcher("addMovie.jsp").forward(request, response);
            } else {
                // Insert movie into database
                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    conn = DbConnection.getConnection();
                    String query = "INSERT INTO movies (title, description, release_date, duration, genre) VALUES (?, ?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, title);
                    pstmt.setString(2, description);
                    pstmt.setDate(3, Date.valueOf(releaseDate));
                    pstmt.setInt(4, Integer.parseInt(duration));
                    pstmt.setString(5, genre);

                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        // Redirect to manageMovies.jsp after successful insertion
                        response.sendRedirect("manageMovies.jsp");
                    } else {
                        request.setAttribute("errorMessage", "Failed to add the movie. Please try again.");
                        request.getRequestDispatcher("addMovie.jsp").forward(request, response);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "An error occurred while adding the movie. Please try again.");
                    request.getRequestDispatcher("addMovie.jsp").forward(request, response);
                } finally {
                    try {
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    %>
</body>
</html>
