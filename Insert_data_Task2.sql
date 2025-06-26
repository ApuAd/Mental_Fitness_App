-- Add users
INSERT INTO Users (name, email, age, gender, join_date)
VALUES 
('Ravi Kumar', 'ravi.k@example.com', 28, 'Male', CURRENT_DATE), -- user_id = 1
('Ananya Sen', 'ananya.sen@example.com', 26, 'Female', CURRENT_DATE), -- user_id = 2
('Mohit Das', 'mohit.d@example.com', 32, 'Male', CURRENT_DATE); -- user_id = 3


-- Devices used by each user
INSERT INTO Devices (user_id, device_type, os_version, app_version)
VALUES 
(1, 'Android', 'Android 13', 'v2.4.1'), -- Device for Ravi
(2, 'iOS', 'iOS 17', 'v3.1.0'),         -- Device for Ananya
(3, 'Web', NULL, 'v1.8.5');             -- Web usage by Mohit

-- Available products
INSERT INTO Products (product_name, product_type, price)
VALUES 
('Pro Focus Pack', 'One-time', 499.00),
('Monthly Subscription', 'Subscription', 299.00),
('Elevate Hoodie', 'Merchandise', 799.00);

-- Modules for cognitive improvement
INSERT INTO TrainingModules (module_name, category)
VALUES 
('Cognitive Sharpness', 'Memory'),
('Deep Focus', 'Focus'),
('Quick Decision', 'Reflex');

-- Exercises under different modules
INSERT INTO Exercises (module_id, exercise_name, instructions)
VALUES 
(1, 'Pattern Recall', 'Match hidden cards from memory.'),
(2, 'Distraction Dodge', 'Avoid irrelevant options.'),
(3, 'Fast Reaction', 'Tap as soon as you see green.');

-- Sessions by users
INSERT INTO Sessions (user_id, module_id, session_type)
VALUES 
(1, 1, 'training'), -- Ravi doing Memory module
(2, 2, 'training'), -- Ananya doing Focus module
(3, 3, 'training'); -- Mohit doing Reflex module

-- Results of exercises
INSERT INTO ExerciseResults (session_id, exercise_id, score, accuracy_percent, reaction_time_ms)
VALUES 
(1, 1, 85, 92.0, 1040),
(2, 2, 78, 88.5, 980),
(3, 3, 90, 95.2, 875);

-- Meditation sessions completed by users
INSERT INTO MeditationSessions (user_id, duration_minutes, mood_before, mood_after)
VALUES 
(1, 10, 'Anxious', 'Calm'),
(2, 15, 'Neutral', 'Happy'),
(3, 20, 'Sad', 'Relaxed');

-- Daily mood logs
INSERT INTO MoodLogs (user_id, mood_level, note)
VALUES 
(1, 7, 'Feeling okay.'),
(2, 9, 'Great day!'),
(3, 4, 'Stressful work.');

-- Mental health assessments
INSERT INTO Assessments (name, description, num_questions)
VALUES 
('PHQ-9', 'Depression screening tool', 9),
('GAD-7', 'General anxiety disorder scale', 7),
('Focus Scale', 'Attention and concentration', 10);

-- Results of completed assessments
INSERT INTO AssessmentResults (user_id, assessment_id, score)
VALUES 
(1, 1, 8), -- Ravi's PHQ-9
(2, 2, 5), -- Ananya's GAD-7
(3, 3, 7); -- Mohit's Focus Score

-- AI-generated training suggestions
INSERT INTO AIRecommendations (user_id, recommended_module, reason)
VALUES 
(1, 2, 'Low focus performance in recent sessions.'),
(2, 1, 'Memory scores trending down.'),
(3, 3, 'Strong reflex improvement potential.');

-- Purchase history
INSERT INTO InAppPurchases (user_id, product_ref, amount, platform)
VALUES 
(1, 1, 499.00, 'Android'), -- Ravi buys Pro Focus
(2, 2, 299.00, 'iOS'),     -- Ananya subscribes
(3, 3, 799.00, 'Web');     -- Mohit buys hoodie

-- Updates to exercises
INSERT INTO ExerciseVersions (exercise_id, version_num, change_summary)
VALUES 
(1, 2, 'Improved card layout for better visibility.'),
(2, 3, 'Added new levels.'),
(3, 2, 'Increased speed of color flash.');

-- Meditation version changes
INSERT INTO MeditationVersions (meditation_id, version_num, change_summary)
VALUES 
(1, 2, 'Added background music.'),
(2, 2, 'Voice guidance improved.'),
(3, 3, 'Reduced session duration.');

-- Ongoing or past clinical studies
INSERT INTO ClinicalStudies (title, description, start_date, end_date)
VALUES 
('Mind & Mood 2025', 'Study on app impact on mood.', '2025-01-01', '2025-06-01'),
('Focus First', 'Research on focus training.', '2025-02-15', '2025-07-15'),
('Sleep Aid Study', 'Examining sleep-related meditation.', '2025-03-01', '2025-08-31');


-- Users who joined studies
INSERT INTO StudyParticipants (study_id, user_id)
VALUES 
(1, 1), -- Ravi in Mind & Mood
(2, 2), -- Ananya in Focus First
(3, 3); -- Mohit in Sleep Aid Study
