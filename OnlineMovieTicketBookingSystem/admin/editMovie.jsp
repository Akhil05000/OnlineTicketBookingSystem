<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DbConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Movie - Admin Dashboard</title>
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
    <h1>Edit Movie</h1>
    
    <div class="form-container">
        <%
            // Declare variables for movie details
            String movieId = request.getParameter("movieId");
            String title = "";
            String description = "";
            String releaseDate = "";
            String duration = "";
            String genre = "";

            // Fetch movie details if the movieId is provided
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            if (movieId != null && !movieId.isEmpty()) {
                try {
                    conn = DbConnection.getConnection();
                    String query = "SELECT * FROM movies WHERE movie_id = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, Integer.parseInt(movieId));
                    rs = pstmt.executeQuery();

                    // If movie exists, populate the fields
                    if (rs.next()) {
                        title = rs.getString("title");
                        description = rs.getString("description");
                        releaseDate = rs.getDate("release_date").toString();
                        duration = String.valueOf(rs.getInt("duration"));
                        genre = rs.getString("genre");
                    } else {
                        out.println("<p>Movie not found!</p>");
                        return;
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Error fetching movie details. Please try again later.</p>");
                    return;
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }

            if ("POST".equalsIgnoreCase(request.getMethod())) {
                // Get form data (no need to declare the variables again)
                title = request.getParameter("title");
                description = request.getParameter("description");
                releaseDate = request.getParameter("releaseDate");
                duration = request.getParameter("duration");
                genre = request.getParameter("genre");

                // Validate form data
                if (title == null || title.isEmpty() || description == null || description.isEmpty() ||
                    releaseDate == null || releaseDate.isEmpty() || duration == null || duration.isEmpty() ||
                    genre == null || genre.isEmpty()) {
                    request.setAttribute("errorMessage", "All fields are required.");
                    request.getRequestDispatcher("editMovie.jsp?movieId=" + movieId).forward(request, response);
                } else {
                    // Update movie in the database
                    try {
                        conn = DbConnection.getConnection();
                        String query = "UPDATE movies SET title = ?, description = ?, release_date = ?, duration = ?, genre = ? WHERE movie_id = ?";
                        pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, title);
                        pstmt.setString(2, description);
                        pstmt.setDate(3, Date.valueOf(releaseDate));
                        pstmt.setInt(4, Integer.parseInt(duration));
                        pstmt.setString(5, genre);
                        pstmt.setInt(6, Integer.parseInt(movieId));

                        int rowsAffected = pstmt.executeUpdate();
                        if (rowsAffected > 0) {
                            // Redirect to manageMovies.jsp after successful update
                            response.sendRedirect("manageMovies.jsp");
                        } else {
                            request.setAttribute("errorMessage", "Failed to update the movie. Please try again.");
                            request.getRequestDispatcher("editMovie.jsp?movieId=" + movieId).forward(request, response);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        request.setAttribute("errorMessage", "An error occurred while updating the movie. Please try again.");
                        request.getRequestDispatcher("editMovie.jsp?movieId=" + movieId).forward(request, response);
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

        <!-- Movie Details Form -->
        <form action="editMovie.jsp" method="post">
            <!-- Display error message if any -->
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
            <div class="error"><%= errorMessage %></div>
            <% 
                }
            %>

            <input type="hidden" name="movieId" value="<%= movieId %>">

            <label for="title">Movie Title:</label>
            <input type="text" id="title" name="title" value="<%= title %>" required>

            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="4" required><%= description %></textarea>

            <label for="releaseDate">Release Date:</label>
            <input type="date" id="releaseDate" name="releaseDate" value="<%= releaseDate %>" required>

            <label for="duration">Duration (in minutes):</label>
            <input type="number" id="duration" name="duration" value="<%= duration %>" min="1" required>

            <label for="genre">Genre:</label>
            <select id="genre" name="genre" required>
                <option value="Action" <%= "Action".equals(genre) ? "selected" : "" %>>Action</option>
                <option value="Comedy" <%= "Comedy".equals(genre) ? "selected" : "" %>>Comedy</option>
                <option value="Drama" <%= "Drama".equals(genre) ? "selected" : "" %>>Drama</option>
                <option value="Horror" <%= "Horror".equals(genre) ? "selected" : "" %>>Horror</option>
                <option value="Romance" <%= "Romance".equals(genre) ? "selected" : "" %>>Romance</option>
                <option value="Thriller" <%= "Thriller".equals(genre) ? "selected" : "" %>>Thriller</option>
                <option value="Sci-Fi" <%= "Sci-Fi".equals(genre) ? "selected" : "" %>>Sci-Fi</option>
                <option value="Fantasy" <%= "Fantasy".equals(genre) ? "selected" : "" %>>Fantasy</option>
            </select>

            <button type="submit">Save Changes</button>
        </form>
    </div>
</body>
</html>
