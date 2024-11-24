<%@ page import="java.sql.*" %>
<%@ page import="utils.DbConnection" %>
<%
    // Get the movie id parameter from the request
    String idParam = request.getParameter("id");
    out.println("Received movie ID: " + idParam); // Debugging line

    // Check if the id parameter is provided and is a valid number
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);  // Parse the id parameter as an integer

            // Establish a connection to the database
            Connection conn = DbConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM movies WHERE movie_id = ?");
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            // Check if a movie with the given ID exists
            if (rs.next()) {
                // Display movie details
%>
<!DOCTYPE html>
<html>
<head>
    <title>Movie Details</title>
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
            background: rgba(0, 0, 0, 0.5); /* Semi-transparent black overlay */
            z-index: -1;
        }

        .container {
            background-color: rgba(0, 0, 0, 0.7); /* Dark background for content */
            border-radius: 8px;
            padding: 30px;
            width: 80%;
            max-width: 600px;
            text-align: center;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
        }

        h1 {
            font-size: 40px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
        }

        p {
            font-size: 18px;
            margin-bottom: 15px;
            line-height: 1.6;
        }

        a {
            text-decoration: none;
            color: #007bff;
            font-size: 18px;
            font-weight: bold;
            padding: 10px 20px;
            border: 2px solid #007bff;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        a:hover {
            background-color: #007bff;
            color: white;
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
        <h1><%= rs.getString("title") %></h1>
        <p><strong>Genre:</strong> <%= rs.getString("genre") %></p>
        <p><strong>Description:</strong> <%= rs.getString("description") %></p>
        <a href="../booking/bookTicket.jsp?movieId=<%= id %>">Book Ticket</a>
    </div>

    <footer>
        <p>&copy; 2024 Online Movie Ticket Booking</p>
    </footer>
</body>
</html>
<%
            } else {
                // Movie not found
                out.println("<p style='color:red;'>No movie found with the specified ID.</p>");
            }
            rs.close();
            pstmt.close();
            conn.close();

        } catch (NumberFormatException e) {
            // Handle invalid number format for the id parameter
            out.println("<p style='color:red;'>Invalid movie ID format. Please check the URL.</p>");
        } catch (SQLException e) {
            // Handle SQL exceptions (e.g., database connection issues)
            e.printStackTrace();
            out.println("<p style='color:red;'>There was an error retrieving the movie details.</p>");
        }
    } else {
        // If the id parameter is missing or empty
        out.println("<p style='color:red;'>Movie ID is missing or invalid in the request.</p>");
    }
%>
</html>
