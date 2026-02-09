-- Shipment Tracking System Database Schema
-- Run this SQL in your MySQL database (phpMyAdmin or MySQL client)

CREATE DATABASE IF NOT EXISTS shipment_tracker;
USE shipment_tracker;

-- Admin users table
CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin user
-- Password: admin123 (you should change this after first login)
INSERT INTO admins (email, password) VALUES ('admin@fx.com', 'admin123');

-- Shipments table
CREATE TABLE IF NOT EXISTS shipments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tracking_code VARCHAR(50) UNIQUE NOT NULL,
    client_name VARCHAR(255) NOT NULL,
    client_email VARCHAR(255),
    client_phone VARCHAR(50),
    status ENUM('pending', 'in-transit', 'delivered') DEFAULT 'pending',
    origin VARCHAR(255) NOT NULL,
    destination VARCHAR(255) NOT NULL,
    description TEXT,
    weight DECIMAL(10, 2),
    estimated_delivery DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_tracking_code (tracking_code),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
);

-- Timeline/tracking history table
CREATE TABLE IF NOT EXISTS tracking_timeline (
    id INT AUTO_INCREMENT PRIMARY KEY,
    shipment_id INT NOT NULL,
    status VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (shipment_id) REFERENCES shipments(id) ON DELETE CASCADE,
    INDEX idx_shipment_id (shipment_id)
);
