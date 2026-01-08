# Resume Keyword Match Database (SQLite)

A lightweight ATS-style project that stores resumes and job postings, extracts skill keywords, and calculates a resume to job match score using SQL joins and aggregation. Includes an application tracker to manage job pipeline status.

## Features
- Stores resumes and job postings in a normalized SQLite schema
- Maintains a keyword library (skills)
- Many-to-many mapping:
  - `resume_keywords` links resumes → keywords
  - `job_keywords` links jobs → keywords
- Computes match percentage and matched keyword count in `match_scores`
- Tracks applications and status in `applications`
- Prevents duplicate applications with a unique index on `(resume_id, job_id)`

## Tech
- SQLite
- DB Browser for SQLite

## Files
- `schema.sql` — creates all tables and indexes
- `seed.sql` — inserts sample resume, job posting, and keywords
- `queries.sql` — extraction, scoring, matched keywords, and pipeline query
- `resume_match.db` — the database file (optional to include)

## How to Run (DB Browser for SQLite)
1. Open `resume_match.db` (or create a new database)
2. Run `schema.sql` in the **Execute SQL** tab
3. Run `seed.sql`
4. Run `queries.sql`
5. View results:
   - `SELECT * FROM match_scores;`
   - `SELECT * FROM applications;`

## Example Output
- `match_scores` shows match percentage between a resume and a job posting
- `applications` shows applied jobs with status and date
