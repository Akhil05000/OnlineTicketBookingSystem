<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DbConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movie List</title>
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

        h1 {
            text-align: center;
            color: #fff;
            padding: 20px;
            font-size: 36px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
        }

        table {
            width: 80%;
            margin: 50px auto;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.8); /* Transparent white background for the table */
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border: 1px solid #ccc;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        td {
            background-color: #f9f9f9;
        }

        td a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        td a:hover {
            color: #0056b3;
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
    <h1>Available Movies</h1>
    <table>
        <tr>
            <th>Title</th>
            <th>Description</th>
            <th>Release Date</th>
            <th>Duration</th>
            <th>Genre</th>
            <th>Details</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                conn = DbConnection.getConnection();
                stmt = conn.createStatement();
                String query = "SELECT * FROM movies";
                rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int movieId = rs.getInt("movie_id"); // Ensure movie_id is fetched
        %>
                    <tr>
                        <td><%= rs.getString("title") %></td>
                        <td><%= rs.getString("description") %></td>
                        <td><%= rs.getDate("release_date") %></td>
                        <td><%= rs.getInt("duration") %> mins</td>
                        <td><%= rs.getString("genre") %></td>
                        <td>
                            <a href="../movies/movieDetails.jsp?id=<%= movieId %>">View Details</a>
                        </td>
                    </tr>
        <%
                }
            } catch (SQLException e) {
                java.io.StringWriter sw = new java.io.StringWriter();
                java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                e.printStackTrace(pw); // Write stack trace to StringWriter
                out.println("<pre>" + sw.toString() + "</pre>"); // Output error to JSP
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        %>
    </table>

    <footer>
        <p>&copy; 2024 Online Movie Ticket Booking</p>
    </footer>
</body>
</html>
