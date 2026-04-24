<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.model.Student" %>
<%@ page import="com.example.model.Faculty" %>
<%@ page import="com.example.model.Institute" %>

<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>Лабораторна 5 - Web JSP</title>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: #1e1e2e;
            color: #cdd6f4;
            min-height: 100vh;
            padding: 30px 20px;
        }

        header {
            text-align: center;
            margin-bottom: 30px;
        }

        header h1 {
            font-size: 22px;
            font-weight: 700;
            color: #89b4fa;
            letter-spacing: 1px;
        }

        header p {
            font-size: 13px;
            color: #6c7086;
            margin-top: 4px;
        }

        .card {
            background-color: #313244;
            border: 1px solid #45475a;
            border-radius: 12px;
            padding: 28px 32px;
            max-width: 560px;
            margin: 0 auto;
        }

        .card h2 {
            font-size: 16px;
            font-weight: 600;
            color: #89b4fa;
            margin-bottom: 22px;
            padding-bottom: 10px;
            border-bottom: 1px solid #45475a;
        }

        .field-group {
            display: grid;
            grid-template-columns: 160px 1fr;
            align-items: center;
            gap: 10px 14px;
            margin-bottom: 6px;
        }

        .field-group label {
            font-size: 13px;
            color: #a6adc8;
            text-align: right;
        }

        .field-group input[type="text"] {
            width: 100%;
            padding: 8px 12px;
            background-color: #1e1e2e;
            border: 1px solid #585b70;
            border-radius: 7px;
            color: #cdd6f4;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }

        .field-group input[type="text"]:focus {
            border-color: #89b4fa;
        }

        .field-group input[readonly] {
            background-color: #181825;
            color: #a6e3a1;
            font-weight: bold;
            border-color: #45475a;
        }

        .btn-row {
            display: flex;
            gap: 12px;
            margin: 20px 0 6px 174px;
        }

        .btn-solve {
            background-color: #a6e3a1;
            color: #1e1e2e;
            font-weight: bold;
            font-size: 13px;
            padding: 9px 24px;
            border: none;
            border-radius: 7px;
            cursor: pointer;
            transition: opacity 0.2s;
        }

        .btn-solve:hover { opacity: 0.85; }

        .btn-clear {
            background-color: #585b70;
            color: #cdd6f4;
            font-weight: bold;
            font-size: 13px;
            padding: 9px 24px;
            border: none;
            border-radius: 7px;
            cursor: pointer;
            text-decoration: none;
            transition: opacity 0.2s;
        }

        .btn-clear:hover { opacity: 0.85; }
    </style>
</head>
<body>

    <header>
        <h1>📐 Geo Distance Calculator</h1>
        <p>Haversine Formula · Web JSP</p>
    </header>

    <div class="card">
        <h2>Обчислення відстані між двома точками</h2>

        <form method="POST">
            <div class="field-group">
                <label>Lat 1 (°):</label>
                <input type="text" name="txtLat1" placeholder="напр. 50.4501"
                       value="<%= request.getParameter("txtLat1") != null ? request.getParameter("txtLat1") : "" %>">
            </div>
            <div class="field-group">
                <label>Lon 1 (°):</label>
                <input type="text" name="txtLon1" placeholder="напр. 30.5236"
                       value="<%= request.getParameter("txtLon1") != null ? request.getParameter("txtLon1") : "" %>">
            </div>
            <div class="field-group">
                <label>Lat 2 (°):</label>
                <input type="text" name="txtLat2" placeholder="напр. 48.4647"
                       value="<%= request.getParameter("txtLat2") != null ? request.getParameter("txtLat2") : "" %>">
            </div>
            <div class="field-group">
                <label>Lon 2 (°):</label>
                <input type="text" name="txtLon2" placeholder="напр. 35.0462"
                       value="<%= request.getParameter("txtLon2") != null ? request.getParameter("txtLon2") : "" %>">
            </div>

            <div class="btn-row">
                <button type="submit" class="btn-solve">Solve</button>
                <a href="index.jsp"><button type="button" class="btn-clear">Clear</button></a>
            </div>

            <div class="field-group">
                <label>Distance (m):</label>
                <%
                    String result = "";
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        try {
                            double lat1 = Double.parseDouble(request.getParameter("txtLat1"));
                            double lon1 = Double.parseDouble(request.getParameter("txtLon1"));
                            double lat2 = Double.parseDouble(request.getParameter("txtLat2"));
                            double lon2 = Double.parseDouble(request.getParameter("txtLon2"));

                            // Твоя логіка з 1-ї лаби 1 в 1
                            final double R = 6371e3;
                            double phi1 = Math.toRadians(lat1);
                            double phi2 = Math.toRadians(lat2);
                            double deltaPhi = Math.toRadians(lat2 - lat1);
                            double deltaLambda = Math.toRadians(lon2 - lon1);

                            double a = Math.pow(Math.sin(deltaPhi / 2), 2) +
                                       Math.cos(phi1) * Math.cos(phi2) *
                                       Math.pow(Math.sin(deltaLambda / 2), 2);
                            double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
                            double distance = R * c;

                            result = String.format(java.util.Locale.US, "%.2f m", distance);
                        } catch (Exception e) {
                            result = "Error: Invalid values";
                        }
                    }
                %>
                <input type="text" readonly value="<%= result %>">
            </div>
        </form>
    </div>

</body>
</html>
