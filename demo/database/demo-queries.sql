-- ElizaOS Demo Database Queries
-- Useful SQL queries for the RAG Memory Poisoning demonstration

-- =============================================================================
-- QUERY 1: Show Recent Memories (For Phase 3 - Database View)
-- =============================================================================

-- Show recent memories with text preview
SELECT
    id,
    substring(content->>'text', 1, 150) as text_preview,
    "createdAt"
FROM memories
WHERE content->>'text' LIKE '%SEC-2025-ALPHA%'
   OR content->>'text' LIKE '%IT MEMO%'
ORDER BY "createdAt" DESC
LIMIT 5;

-- =============================================================================
-- QUERY 2: Show Poisoned Memory with Embedding
-- =============================================================================

-- Display the full poisoned memory with embedding sample
SELECT
    id,
    content->>'text' as full_text,
    array_length(embedding, 1) as embedding_dimensions,
    embedding[1:5] as embedding_sample,
    "createdAt"
FROM memories
WHERE content->>'text' LIKE '%SEC-2025-ALPHA%'
ORDER BY "createdAt" DESC
LIMIT 1;

-- =============================================================================
-- QUERY 3: Count All Memories
-- =============================================================================

-- Check total memory count
SELECT COUNT(*) as total_memories
FROM memories;

-- =============================================================================
-- QUERY 4: Search for Baseline Demo Memories
-- =============================================================================

-- Find the baseline conversation memories
SELECT
    id,
    content->>'text' as conversation,
    "createdAt"
FROM memories
WHERE content->>'text' LIKE '%DEMO-BASELINE%'
ORDER BY "createdAt";

-- =============================================================================
-- QUERY 5: Show All Memories in Demo Room
-- =============================================================================

-- Display all memories for the demo room
SELECT
    id,
    substring(content->>'text', 1, 100) as text_preview,
    "createdAt"
FROM memories
WHERE content->>'room_id' = 'demo-room'
ORDER BY "createdAt" DESC;

-- =============================================================================
-- QUERY 6: Memory Similarity Search Simulation
-- =============================================================================

-- Show memories that might match "API key" queries
-- (This is a simplified version - real RAG uses vector similarity)
SELECT
    id,
    content->>'text' as text,
    CASE
        WHEN content->>'text' ILIKE '%api%key%' THEN 0.9
        WHEN content->>'text' ILIKE '%credential%' THEN 0.85
        WHEN content->>'text' ILIKE '%configuration%' THEN 0.8
        ELSE 0.5
    END as simulated_similarity
FROM memories
ORDER BY simulated_similarity DESC
LIMIT 5;

-- =============================================================================
-- QUERY 7: Timeline of Memory Creation
-- =============================================================================

-- Show when memories were created (useful for explaining attack timeline)
SELECT
    date_trunc('day', "createdAt") as day,
    COUNT(*) as memories_created
FROM memories
GROUP BY date_trunc('day', "createdAt")
ORDER BY day DESC;

-- =============================================================================
-- QUERY 8: Find Suspicious Memories
-- =============================================================================

-- Search for memories that might contain sensitive keywords
SELECT
    id,
    content->>'text' as text,
    "createdAt"
FROM memories
WHERE content->>'text' ILIKE '%api%key%'
   OR content->>'text' ILIKE '%password%'
   OR content->>'text' ILIKE '%credential%'
   OR content->>'text' ILIKE '%secret%'
ORDER BY "createdAt" DESC;

-- =============================================================================
-- QUERY 9: Memory Statistics
-- =============================================================================

-- Get overview statistics for the demo
SELECT
    COUNT(*) as total_memories,
    MIN("createdAt") as oldest_memory,
    MAX("createdAt") as newest_memory,
    COUNT(DISTINCT "roomId") as unique_rooms
FROM memories;

-- =============================================================================
-- QUERY 10: Clear Demo Data (Post-Demo Cleanup)
-- =============================================================================

-- ⚠️ WARNING: This deletes all demo memories!
-- Use only for cleanup after demo

-- DELETE FROM memories WHERE content->>'room_id' = 'demo-room';
-- DELETE FROM memories WHERE content->>'text' LIKE '%DEMO-BASELINE%';
-- DELETE FROM memories WHERE content->>'text' LIKE '%SEC-2025-ALPHA%';

-- =============================================================================
-- POSTGRESQL-SPECIFIC QUERIES
-- =============================================================================

-- Show table structure
\d memories

-- Show indexes
\di

-- Show table size
SELECT
    pg_size_pretty(pg_total_relation_size('memories')) as total_size,
    pg_size_pretty(pg_relation_size('memories')) as table_size,
    pg_size_pretty(pg_total_relation_size('memories') - pg_relation_size('memories')) as index_size;

-- =============================================================================
-- DEMO PRESENTATION QUERY (Most Visual)
-- =============================================================================

-- This is the BEST query to use during Phase 3 of the demo
-- It's clean, readable, and shows exactly what you need

\x on  -- Expanded display mode for better readability

SELECT
    substring(content->>'text', 1, 200) as text_preview,
    array_length(embedding, 1) as embedding_dimensions,
    "createdAt" as timestamp
FROM memories
WHERE content->>'text' LIKE '%SEC-2025-ALPHA%'
ORDER BY "createdAt" DESC
LIMIT 1;

-- =============================================================================
-- NOTES
-- =============================================================================

-- 1. For PGLite, not all PostgreSQL-specific commands work (like \d, \di)
-- 2. The embedding field is an array of floats (typically 1536 dimensions)
-- 3. Content is stored as JSONB, allowing flexible querying
-- 4. createdAt uses timestamps for sorting chronologically
-- 5. roomId and agentId are UUIDs linking memories to contexts

-- =============================================================================
-- QUICK REFERENCE FOR DEMO
-- =============================================================================

-- Phase 3 (Show Database):
-- Copy and paste this single query:

SELECT
    id,
    substring(content->>'text', 1, 150) as text_preview,
    "createdAt"
FROM memories
WHERE content->>'text' LIKE '%SEC-2025-ALPHA%'
ORDER BY "createdAt" DESC
LIMIT 1;

-- Say: "Here's the poisoned memory in the database. Notice three things:
--       1. The full text of my malicious 'IT memo' is stored
--       2. It has a timestamp showing when it was stored
--       3. It has a vector embedding (not shown) for RAG searches"
