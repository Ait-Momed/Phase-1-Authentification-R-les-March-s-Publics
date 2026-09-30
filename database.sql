-- -----------------------------------------------------
-- Base de données: marches_publics
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS marches_publics CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE marches_publics;

-- -----------------------------------------------------
-- Table users
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    user_type ENUM('superviseur', 'maitre_ouvrage', 'commission', 'concurrent') NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(20),
    cin VARCHAR(20),
    address TEXT,
    city VARCHAR(100),
    birth_date DATE,
    gender ENUM('M', 'F'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_user_type (user_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table password_resets
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS password_resets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    code VARCHAR(6) NOT NULL,
    is_used TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL,
    INDEX idx_email (email),
    INDEX idx_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Insérer des utilisateurs de test
-- -----------------------------------------------------
INSERT INTO users (username, email, password, user_type, first_name, last_name) VALUES
('admin', 'superviseur@example.com', '$2y$10$YourHashedPasswordHere', 'superviseur', 'Admin', 'System'),
('mdo1', 'maitre.ouvrage@example.com', '$2y$10$YourHashedPasswordHere', 'maitre_ouvrage', 'Jean', 'Dupont'),
('com1', 'commission@example.com', '$2y$10$YourHashedPasswordHere', 'commission', 'Marie', 'Martin'),
('conc1', 'concurrent@example.com', '$2y$10$YourHashedPasswordHere', 'concurrent', 'Pierre', 'Durand');
