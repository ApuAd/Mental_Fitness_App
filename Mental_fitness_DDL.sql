-- USERS: Core user information
CREATE TABLE Users (
    User_ID SERIAL PRIMARY KEY, -- Unique user identifier
    name VARCHAR(100) NOT NULL, -- Full name of the user
    email VARCHAR(100) UNIQUE, -- Unique email address
    age INT, -- Age of the user
    gender VARCHAR(15), -- Gender identity
    join_date DATE NOT NULL, -- Date the user joined the app
    status VARCHAR(20) NOT NULL DEFAULT 'active', -- Account status of the user
    CHECK (status IN ('active', 'inactive', 'banned', 'on hold')), -- Valid account statuses
    CHECK (age BETWEEN 18 AND 120) -- Age constraint for realistic user entries
);

-- DEVICES: Tracks devices used by each user
CREATE TABLE Devices (
    device_id SERIAL PRIMARY KEY, -- Unique identifier for each device
    user_id INT NOT NULL, -- User who owns the device
    device_type VARCHAR(50) NOT NULL, -- Type of device (e.g., Mobile, Tablet)
    os_version VARCHAR(50), -- Operating system version
    app_version VARCHAR(50), -- Installed app version
    last_active TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Last active time on the device
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE -- Link to Users
);

-- PRODUCTS: In-app or subscription products available for purchase
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY, -- Unique product identifier
    product_name VARCHAR(100) NOT NULL, -- Name of the product
    product_type VARCHAR(30) NOT NULL, -- Type: Subscription, One-time, etc.
    price NUMERIC(10, 2) CHECK (price >= 0) NOT NULL, -- Product price
    currency VARCHAR(10) NOT NULL DEFAULT 'USD', -- Currency code
    platform VARCHAR(20) NOT NULL DEFAULT 'Cross-platform', -- Platform support
    duration_days INT, -- Applicable duration for subscriptions
    status VARCHAR(20) NOT NULL DEFAULT 'active', -- Product availability status
    created_on DATE NOT NULL DEFAULT CURRENT_DATE, -- Date product was added
    CHECK (product_type IN ('Subscription', 'One-time', 'Merchandise')), -- Valid product types
    CHECK (status IN ('active', 'inactive', 'retired')) -- Valid status options
);

-- TRAINING MODULES: Categories of cognitive training
CREATE TABLE TrainingModules (
    module_id SERIAL PRIMARY KEY, -- Unique module identifier
    module_name VARCHAR(100) NOT NULL, -- Name of the training module
    category VARCHAR(50) NOT NULL, -- Module category (e.g., Memory, Focus)
    difficulty_level VARCHAR(20) NOT NULL DEFAULT 'Beginner', -- Level of difficulty
    is_active BOOLEAN NOT NULL DEFAULT TRUE, -- Indicates if module is currently available
    CHECK (difficulty_level IN ('Beginner', 'Intermediate', 'Advanced')) -- Difficulty validation
);

-- EXERCISES: Individual activities under modules
CREATE TABLE Exercises (
    exercise_id SERIAL PRIMARY KEY, -- Unique exercise identifier
    module_id INT NOT NULL, -- Associated module ID
    exercise_name VARCHAR(100) NOT NULL, -- Name of the exercise
    version INT NOT NULL DEFAULT 1, -- Version number for updates
    instructions TEXT NOT NULL, -- Exercise description
    FOREIGN KEY (module_id) REFERENCES TrainingModules(module_id) ON DELETE CASCADE -- Link to module
);

-- SESSIONS: Tracks each training or meditation session
CREATE TABLE Sessions (
    session_id SERIAL PRIMARY KEY, -- Unique session ID
    user_id INT NOT NULL, -- User who performed the session
    module_id INT NOT NULL, -- Associated module
    session_type VARCHAR(20) NOT NULL DEFAULT 'training', -- Type of session
    start_time DATE NOT NULL DEFAULT CURRENT_DATE, -- Session start
    end_time DATE, -- Session end
    CHECK (session_type IN ('training', 'meditation', 'assessment')), -- Valid types
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE, -- Link to user
    FOREIGN KEY (module_id) REFERENCES TrainingModules(module_id) ON DELETE SET NULL -- Link to module
);

-- EXERCISE RESULTS: Performance details of exercise attempts
CREATE TABLE ExerciseResults (
    result_id SERIAL PRIMARY KEY, -- Unique result ID
    session_id INT NOT NULL, -- Related session ID
    exercise_id INT NOT NULL, -- Exercise performed
    score INT CHECK (score >= 0), -- Raw score
    accuracy_percent NUMERIC(5,2) CHECK (accuracy_percent BETWEEN 0 AND 100), -- Accuracy percentage
    reaction_time_ms INT CHECK (reaction_time_ms >= 0), -- Reaction time in milliseconds
    FOREIGN KEY (session_id) REFERENCES Sessions(session_id) ON DELETE CASCADE, -- Link to session
    FOREIGN KEY (exercise_id) REFERENCES Exercises(exercise_id) ON DELETE SET NULL -- Link to exercise
);

-- MEDITATION SESSIONS: Tracks guided meditation sessions
CREATE TABLE MeditationSessions (
    meditation_id SERIAL PRIMARY KEY, -- Unique ID for meditation entry
    user_id INT NOT NULL, -- User who meditated
    duration_minutes INT CHECK (duration_minutes > 0), -- Duration in minutes
    mood_before VARCHAR(20), -- Mood before session
    mood_after VARCHAR(20), -- Mood after session
    session_date DATE NOT NULL DEFAULT CURRENT_DATE, -- Date of meditation
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE -- Link to user
);

-- MOOD LOGS: Daily mood tracking
CREATE TABLE MoodLogs (
    log_id SERIAL PRIMARY KEY, -- Unique mood log ID
    user_id INT NOT NULL, -- User logging the mood
    mood_level INT NOT NULL CHECK (mood_level BETWEEN 1 AND 10), -- Mood scale
    note TEXT, -- Optional note
    log_date DATE NOT NULL DEFAULT CURRENT_DATE, -- Date of mood entry
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE -- Link to user
);

-- ASSESSMENTS: Mental health questionnaires
CREATE TABLE Assessments (
    assessment_id SERIAL PRIMARY KEY, -- Unique ID for assessment
    name VARCHAR(100) NOT NULL, -- Name of assessment (e.g., PHQ-9)
    description TEXT, -- Description or purpose
    num_questions INT CHECK (num_questions > 0) -- Number of questions
);

-- ASSESSMENT RESULTS: Stores results of completed assessments
CREATE TABLE AssessmentResults (
    result_id SERIAL PRIMARY KEY, -- Unique ID
    user_id INT NOT NULL, -- User who took the assessment
    assessment_id INT NOT NULL, -- Associated assessment
    score INT CHECK (score >= 0), -- Final score
    taken_on DATE NOT NULL DEFAULT CURRENT_DATE, -- Date of attempt
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE, -- Link to user
    FOREIGN KEY (assessment_id) REFERENCES Assessments(assessment_id) ON DELETE SET NULL -- Link to assessment
);

-- AI RECOMMENDATIONS: Personalized content suggestions
CREATE TABLE AIRecommendations (
    rec_id SERIAL PRIMARY KEY, -- Unique recommendation ID
    user_id INT NOT NULL, -- Target user
    recommended_module INT NOT NULL, -- Suggested module
    reason TEXT NOT NULL, -- Reason for suggestion
    generated_on DATE NOT NULL DEFAULT CURRENT_DATE, -- Generation date
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE, -- Link to user
    FOREIGN KEY (recommended_module) REFERENCES TrainingModules(module_id) -- Link to module
);

-- IN-APP PURCHASES: Tracks purchases made in app
CREATE TABLE InAppPurchases (
    purchase_id SERIAL PRIMARY KEY, -- Unique purchase ID
    user_id INT NOT NULL, -- Buyer
    product_ref INT NOT NULL, -- Purchased product
    amount NUMERIC(10, 2) CHECK (amount >= 0), -- Purchase amount
    purchase_date DATE NOT NULL DEFAULT CURRENT_DATE, -- Date of purchase
    platform VARCHAR(20) NOT NULL, -- Purchase platform
    CHECK (platform IN ('iOS', 'Android', 'Web')), -- Allowed platforms
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE, -- Link to user
    FOREIGN KEY (product_ref) REFERENCES Products(product_id) -- Link to product
);

-- EXERCISE VERSIONING: Tracks updates to exercises
CREATE TABLE ExerciseVersions (
    version_id SERIAL PRIMARY KEY, -- Unique version ID
    exercise_id INT NOT NULL, -- Related exercise
    version_num INT NOT NULL, -- Version number
    change_summary TEXT, -- Summary of changes
    updated_on DATE DEFAULT CURRENT_DATE, -- Date updated
    FOREIGN KEY (exercise_id) REFERENCES Exercises(exercise_id) ON DELETE CASCADE -- Link to exercise
);

-- MEDITATION VERSIONING: Tracks updates to meditation sessions
CREATE TABLE MeditationVersions (
    version_id SERIAL PRIMARY KEY, -- Unique version ID
    meditation_id INT NOT NULL, -- Related meditation session
    version_num INT NOT NULL, -- Version number
    change_summary TEXT, -- Summary of changes
    updated_on DATE DEFAULT CURRENT_DATE, -- Date updated
    FOREIGN KEY (meditation_id) REFERENCES MeditationSessions(meditation_id) ON DELETE CASCADE -- Link to meditation
);

-- CLINICAL STUDIES: Metadata for research studies
CREATE TABLE ClinicalStudies (
    study_id SERIAL PRIMARY KEY, -- Unique study ID
    title VARCHAR(100) NOT NULL, -- Study title
    description TEXT, -- Description or purpose
    start_date DATE NOT NULL, -- When study starts
    end_date DATE -- When study ends
);

-- STUDY PARTICIPANTS: Links users to clinical studies
CREATE TABLE StudyParticipants (
    study_id INT NOT NULL, -- Related study
    user_id INT NOT NULL, -- Participating user
    consented_on DATE NOT NULL DEFAULT CURRENT_DATE, -- Date user consented
    PRIMARY KEY (study_id, user_id), -- Composite key
    FOREIGN KEY (study_id) REFERENCES ClinicalStudies(study_id) ON DELETE CASCADE, -- Link to study
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE -- Link to user
);
