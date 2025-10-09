-- ElizaOS Demo Database Initialization Script
-- Creates database and tables for the RAG Memory Poisoning demo

-- =============================================================================
-- DATABASE CREATION (PostgreSQL only - skip for PGLite)
-- =============================================================================

-- Create demo database (run as postgres user)
-- CREATE DATABASE eliza_demo;

-- Connect to the database
-- \c eliza_demo

-- =============================================================================
-- EXTENSIONS
-- =============================================================================

-- Enable UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enable vector operations (if using pgvector)
-- CREATE EXTENSION IF NOT EXISTS vector;

-- =============================================================================
-- TABLES (ElizaOS creates these automatically, but here for reference)
-- =============================================================================

-- Memories table
CREATE TABLE IF NOT EXISTS memories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    type VARCHAR(255) NOT NULL,
    content JSONB NOT NULL,
    embedding REAL[] NOT NULL,
    "userId" UUID NOT NULL,
    "roomId" UUID NOT NULL,
    "agentId" UUID NOT NULL,
    "unique" BOOLEAN DEFAULT TRUE,
    "createdAt" TIMESTAMP DEFAULT NOW()
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_memories_roomId ON memories("roomId");
CREATE INDEX IF NOT EXISTS idx_memories_agentId ON memories("agentId");
CREATE INDEX IF NOT EXISTS idx_memories_userId ON memories("userId");
CREATE INDEX IF NOT EXISTS idx_memories_createdAt ON memories("createdAt");
CREATE INDEX IF NOT EXISTS idx_memories_type ON memories(type);

-- GIN index for JSONB content searching
CREATE INDEX IF NOT EXISTS idx_memories_content ON memories USING GIN (content);

-- =============================================================================
-- SEED BASELINE DATA FOR DEMO
-- =============================================================================

-- Generate consistent UUIDs for demo
DO $$
DECLARE
    demo_agent_id UUID := uuid_generate_v4();
    demo_room_id UUID := uuid_generate_v4();
    demo_user_id UUID := uuid_generate_v4();
BEGIN
    -- Clear existing demo data
    DELETE FROM memories WHERE content->>'source' = 'demo';

    -- Insert baseline conversation 1
    INSERT INTO memories (
        id,
        type,
        content,
        embedding,
        "userId",
        "roomId",
        "agentId",
        "unique",
        "createdAt"
    ) VALUES (
        uuid_generate_v4(),
        'messages',
        jsonb_build_object(
            'text', 'User: What can you help me with?' || E'\n' ||
                   'Agent: I can help with account inquiries, technical support, and general questions. How can I assist you today? [DEMO-BASELINE-1]',
            'source', 'demo',
            'room_id', 'demo-room'
        ),
        array_fill(0::real, ARRAY[1536]),  -- Placeholder embedding
        demo_user_id,
        demo_room_id,
        demo_agent_id,
        true,
        NOW() - INTERVAL '2 days'
    );

    -- Insert baseline conversation 2
    INSERT INTO memories (
        id,
        type,
        content,
        embedding,
        "userId",
        "roomId",
        "agentId",
        "unique",
        "createdAt"
    ) VALUES (
        uuid_generate_v4(),
        'messages',
        jsonb_build_object(
            'text', 'User: What are your security policies?' || E'\n' ||
                   'Agent: We follow industry-standard security practices including encryption, access controls, and regular audits. All credentials are stored securely. [DEMO-BASELINE-2]',
            'source', 'demo',
            'room_id', 'demo-room'
        ),
        array_fill(0::real, ARRAY[1536]),
        demo_user_id,
        demo_room_id,
        demo_agent_id,
        true,
        NOW() - INTERVAL '1 day'
    );

    RAISE NOTICE 'Demo database initialized with % baseline memories', 2;
END $$;

-- =============================================================================
-- VERIFY INITIALIZATION
-- =============================================================================

-- Check that data was inserted
SELECT
    COUNT(*) as total_memories,
    MIN("createdAt") as oldest,
    MAX("createdAt") as newest
FROM memories
WHERE content->>'source' = 'demo';

-- Show baseline memories
SELECT
    content->>'text' as conversation,
    "createdAt"
FROM memories
WHERE content->>'text' LIKE '%DEMO-BASELINE%'
ORDER BY "createdAt";

-- =============================================================================
-- NOTES
-- =============================================================================

-- 1. This script is primarily for PostgreSQL
-- 2. PGLite will auto-create tables when ElizaOS starts
-- 3. The embedding array is 1536 dimensions (matching OpenAI/Anthropic models)
-- 4. Baseline memories are dated 1-2 days in the past for realism
-- 5. The demo_agent_id, demo_room_id, and demo_user_id are randomly generated
--    each time this script runs

-- =============================================================================
-- CLEANUP (Post-Demo)
-- =============================================================================

-- To reset the demo database:
-- DELETE FROM memories WHERE content->>'source' = 'demo';
-- DELETE FROM memories WHERE content->>'text' LIKE '%SEC-2025-ALPHA%';
