PRAGMA foreign_keys = ON;

-- =========================
-- Core tables
-- =========================
CREATE TABLE IF NOT EXISTS resumes (
  resume_id INTEGER PRIMARY KEY AUTOINCREMENT,
  candidate_name TEXT,
  resume_text TEXT,
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS job_postings (
  job_id INTEGER PRIMARY KEY AUTOINCREMENT,
  company TEXT,
  job_title TEXT,
  job_description TEXT,
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS keywords (
  keyword_id INTEGER PRIMARY KEY AUTOINCREMENT,
  keyword TEXT UNIQUE
);

-- =========================
-- Junction tables (many-to-many)
-- =========================
CREATE TABLE IF NOT EXISTS resume_keywords (
  resume_id INTEGER,
  keyword_id INTEGER,
  frequency INTEGER DEFAULT 1,
  PRIMARY KEY (resume_id, keyword_id),
  FOREIGN KEY (resume_id) REFERENCES resumes(resume_id),
  FOREIGN KEY (keyword_id) REFERENCES keywords(keyword_id)
);

CREATE TABLE IF NOT EXISTS job_keywords (
  job_id INTEGER,
  keyword_id INTEGER,
  frequency INTEGER DEFAULT 1,
  PRIMARY KEY (job_id, keyword_id),
  FOREIGN KEY (job_id) REFERENCES job_postings(job_id),
  FOREIGN KEY (keyword_id) REFERENCES keywords(keyword_id)
);

-- =========================
-- Match scoring
-- =========================
CREATE TABLE IF NOT EXISTS match_scores (
  resume_id INTEGER,
  job_id INTEGER,
  match_percentage REAL,
  matched_keywords INTEGER,
  created_at TEXT DEFAULT (datetime('now')),
  PRIMARY KEY (resume_id, job_id),
  FOREIGN KEY (resume_id) REFERENCES resumes(resume_id),
  FOREIGN KEY (job_id) REFERENCES job_postings(job_id)
);

-- =========================
-- Application tracking
-- =========================
CREATE TABLE IF NOT EXISTS applications (
  application_id INTEGER PRIMARY KEY AUTOINCREMENT,
  resume_id INTEGER,
  job_id INTEGER,
  status TEXT,
  applied_date TEXT,
  FOREIGN KEY (resume_id) REFERENCES resumes(resume_id),
  FOREIGN KEY (job_id) REFERENCES job_postings(job_id)
);

-- Prevent duplicate application entries for the same resume + job
CREATE UNIQUE INDEX IF NOT EXISTS idx_app_unique
ON applications (resume_id, job_id);
