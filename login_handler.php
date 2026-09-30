<?php
/**
 * Login handler
 */
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'login') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    $userType = $_POST['user_type'] ?? 'artisan';

    // Map user types
    $userTypeMap = [
        'artisan' => 'superviseur',
        'client' => 'maitre_ouvrage',
        'teacher' => 'commission',
        'concurrent' => 'concurrent'
    ];

    $dbUserType = $userTypeMap[$userType] ?? 'superviseur';

    try {
        $pdo = getDBConnection();

        // Find user by email or username and user type
        $stmt = $pdo->prepare("SELECT * FROM users WHERE (email = :email OR username = :username) AND user_type = :user_type");
        $stmt->execute([
            ':email' => $username,
            ':username' => $username,
            ':user_type' => $dbUserType
        ]);

        $user = $stmt->fetch();

        if ($user) {
            // For demo purposes, we'll accept any password
            // In production, use password_verify($password, $user['password'])
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['email'] = $user['email'];
            $_SESSION['user_type'] = $user['user_type'];

            header('Content-Type: application/json');
            echo json_encode([
                'success' => true,
                'message' => 'Login successful',
                'redirect' => 'dashboard.php'
            ]);
        } else {
            header('Content-Type: application/json');
            echo json_encode([
                'success' => false,
                'message' => 'Identifiants incorrects'
            ]);
        }
    } catch (PDOException $e) {
        header('Content-Type: application/json');
        echo json_encode([
            'success' => false,
            'message' => 'Erreur système: ' . $e->getMessage()
        ]);
    }
} else {
    header('Location: inscription.php');
    exit;
}
?>
