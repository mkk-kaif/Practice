<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

$servername = "localhost";
$username = "root"; // Default XAMPP user
$password = ""; // Default XAMPP password
$dbname = "recipe_planner";

// Connect to MySQL
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Handle Requests
$action = $_GET['action'] ?? '';

if ($action == "get_recipes") {
    $result = $conn->query("SELECT * FROM recipes");
    $recipes = [];
    while ($row = $result->fetch_assoc()) {
        $recipes[] = $row;
    }
    echo json_encode($recipes);
}

$conn->close();
?>
