<?php
include 'config.php';

$query = "SELECT * FROM quizzes ORDER BY RAND() LIMIT 10";
$stmt = $conn->prepare($query);
$stmt->execute();
$quizzes = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($quizzes);
?>
