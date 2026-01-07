<?php
include 'config.php';

$method = $_SERVER['REQUEST_METHOD'];

if ($method == 'POST') {
    $data = json_decode(file_get_contents("php://input"));
    if (!empty($data->user_id) && isset($data->score)) {
        $user_id = $data->user_id;
        $score = $data->score;

        $query = "INSERT INTO scores (user_id, score) VALUES (?, ?)";
        $stmt = $conn->prepare($query);
        if ($stmt->execute([$user_id, $score])) {
            echo json_encode(["status" => "success", "message" => "Score saved successfully."]);
        } else {
            echo json_encode(["status" => "error", "message" => "Unable to save score."]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "Incomplete data."]);
    }
} else if ($method == 'GET') {
    $query = "SELECT s.score, s.quiz_date, u.username FROM scores s JOIN users u ON s.user_id = u.id ORDER BY s.score DESC LIMIT 10";
    $stmt = $conn->prepare($query);
    $stmt->execute();
    $scores = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($scores);
}
?>
