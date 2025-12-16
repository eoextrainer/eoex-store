-- EOEX Store MySQL Seed Data
INSERT INTO users (email, hashed_password, role) VALUES
('admin@eoex.com', '$2b$12$adminhashedpassword', 'admin'),
('user1@eoex.com', '$2b$12$user1hashedpassword', 'user');

INSERT INTO apps (name, vendor, version, target_platform, downloads, size, host_source, revisions, bugs) VALUES
('Health Tracker', 'EOEX', '1.0.0', 'android', 100, '20MB', 'https://eoex.com/health', '1', ''),
('Finance Guru', 'EOEX', '1.0.0', 'web', 50, '15MB', 'https://eoex.com/finance', '1', '');
