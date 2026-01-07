<?php
include 'config.php';

$query = "SELECT * FROM players";
$stmt = $conn->prepare($query);
$stmt->execute();
$players = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($players);
?>
