PRAGMA foreign_keys = ON;

-- ==========================================
-- 1) Extract keyword matches for resume/job
-- ==========================================
-- Change these IDs to match your resume/job
-- (default uses 1 and 1)
-- ==========================================

-- Clear existing keyword links
DELETE FROM resume_keywords WHERE resume_id = 1;
DELETE FROM job_keywords WHERE job_id = 1;

-- Fill resume_keywords from resume_text
INSERT INTO resume_keywords (resume_id, keyword_id, frequency)
SELECT 1, k.keyword_id, 1
FROM keywords k
WHERE lower((SELECT resume_text FROM resumes WHERE resume_id = 1))
      LIKE '%' || k.keyword || '%';

-- Fill job_keywords from job_description
INSERT INTO job_keywords (job_id, keyword_id, frequency)
SELECT 1, k.keyword_id, 1
FROM keywords k
WHERE lower((SELECT job_description FROM job_postings WHERE job_id = 1))
      LIKE '%' || k.keyword || '%';


-- ==========================================
-- 2) Compute match score and store result
-- ==========================================
DELETE FROM match_scores WHERE resume_id = 1 AND job_id = 1;

INSERT INTO match_scores (resume_id, job_id, match_percentage, matched_keywords)
SELECT
  1 AS resume_id,
  1 AS job_id,
  ROUND(
    (COUNT(*) * 100.0) / (SELECT COUNT(*) FROM job_keywords WHERE job_id = 1),
    2
  ) AS match_percentage,
  COUNT(*) AS matched_keywords
FROM resume_keywords rk
JOIN job_keywords jk
  ON rk.keyword_id = jk.keyword_id
WHERE rk.resume_id = 1 AND jk.job_id = 1;


-- ==========================================
-- 3) Matched keyword list (debug / insight)
-- ==========================================
SELECT k.keyword
FROM resume_keywords rk
JOIN job_keywords jk ON rk.keyword_id = jk.keyword_id
JOIN keywords k ON k.keyword_id = rk.keyword_id
WHERE rk.resume_id = 1 AND jk.job_id = 1
ORDER BY k.keyword;


-- ==========================================
-- 4) Application tracking
-- ==========================================
-- Insert an application (won't duplicate because of unique index)
INSERT OR IGNORE INTO applications (resume_id, job_id, status, applied_date)
VALUES (1, 1, 'Applied', date('now'));

-- View your application pipeline + match score
SELECT
  j.company,
  j.job_title,
  a.status,
  a.applied_date,
  m.match_percentage
FROM applications a
JOIN job_postings j ON a.job_id = j.job_id
JOIN match_scores m ON m.job_id = j.job_id
                   AND m.resume_id = a.resume_id;
