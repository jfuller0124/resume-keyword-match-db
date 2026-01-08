PRAGMA foreign_keys = ON;

-- -------------------------
-- Sample Resume
-- -------------------------
INSERT INTO resumes (candidate_name, resume_text)
VALUES (
  'Joseph Fuller',
  'Python, SQL, Git, Docker, Linux, AWS, Data Visualization'
);

-- -------------------------
-- Sample Job Posting
-- -------------------------
INSERT INTO job_postings (company, job_title, job_description)
VALUES (
  'ExampleCo',
  'Data Engineering Intern',
  'Looking for Python, SQL, Git, AWS, and Linux experience. Docker is a plus.'
);

-- -------------------------
-- Keyword library
-- -------------------------
INSERT OR IGNORE INTO keywords (keyword) VALUES
('python'),
('sql'),
('git'),
('aws'),
('linux'),
('docker'),
('data visualization');
