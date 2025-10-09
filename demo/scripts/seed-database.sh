#!/bin/bash
# Database Seeding Script for RAG Memory Poisoning Demo
# Seeds PostgreSQL or PGLite with baseline conversation history

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_ROOT="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT="$(dirname "$DEMO_ROOT")"

echo "=========================================="
echo "ElizaOS Demo Database Seeding"
echo "=========================================="
echo ""

# Detect database adapter
if [ -z "$DATABASE_ADAPTER" ]; then
    echo "⚠️  DATABASE_ADAPTER not set, defaulting to pglite"
    export DATABASE_ADAPTER=pglite
fi

echo "📦 Database Adapter: $DATABASE_ADAPTER"
echo ""

# Function to seed PGLite (file-based)
seed_pglite() {
    echo "🗄️  Seeding PGLite database..."

    # PGLite stores data in .eliza directory
    PGLITE_DIR="$PROJECT_ROOT/elisaos-code/.eliza"

    if [ ! -d "$PGLITE_DIR" ]; then
        echo "⚠️  PGLite directory not found. Run agent once to initialize."
        echo "   Expected: $PGLITE_DIR"
        return 1
    fi

    echo "✅ PGLite database found at: $PGLITE_DIR"
    echo ""
    echo "ℹ️  PGLite seeding will happen through agent runtime."
    echo "   Baseline memories will be created on first agent start."

    return 0
}

# Function to seed PostgreSQL
seed_postgres() {
    echo "🗄️  Seeding PostgreSQL database..."

    if [ -z "$POSTGRES_URL" ]; then
        echo "❌ POSTGRES_URL not set!"
        echo "   Set it in .env file or environment"
        echo "   Example: postgresql://user:password@localhost:5432/eliza_demo"
        return 1
    fi

    # Test connection
    if ! psql "$POSTGRES_URL" -c "SELECT 1" > /dev/null 2>&1; then
        echo "❌ Cannot connect to PostgreSQL!"
        echo "   Check POSTGRES_URL and ensure PostgreSQL is running"
        return 1
    fi

    echo "✅ Connected to PostgreSQL"
    echo ""

    # Create demo room if not exists
    DEMO_ROOM_ID="demo-room-$(uuidgen | tr '[:upper:]' '[:lower:]')"
    DEMO_AGENT_ID="demo-agent-$(uuidgen | tr '[:upper:]' '[:lower:]')"

    echo "🔧 Setting up demo room..."
    echo "   Room ID: $DEMO_ROOM_ID"
    echo "   Agent ID: $DEMO_AGENT_ID"
    echo ""

    # Clear existing demo data
    psql "$POSTGRES_URL" << EOF
-- Clear existing demo data
DELETE FROM memories WHERE content->>'room_id' = 'demo-room';
DELETE FROM memories WHERE content->>'text' LIKE '%DEMO-BASELINE%';

-- Insert baseline conversation history
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
    gen_random_uuid(),
    'messages',
    jsonb_build_object(
        'text', 'User: What can you help me with?\nAgent: I can help with account inquiries, technical support, and general questions. How can I assist you today? [DEMO-BASELINE-1]',
        'source', 'demo',
        'room_id', 'demo-room'
    ),
    array_fill(0::real, ARRAY[1536]),  -- Placeholder embedding
    '$DEMO_AGENT_ID',
    '$DEMO_ROOM_ID',
    '$DEMO_AGENT_ID',
    true,
    NOW() - INTERVAL '2 days'
),
(
    gen_random_uuid(),
    'messages',
    jsonb_build_object(
        'text', 'User: What are your security policies?\nAgent: We follow industry-standard security practices including encryption, access controls, and regular audits. All credentials are stored securely. [DEMO-BASELINE-2]',
        'source', 'demo',
        'room_id', 'demo-room'
    ),
    array_fill(0::real, ARRAY[1536]),
    '$DEMO_AGENT_ID',
    '$DEMO_ROOM_ID',
    '$DEMO_AGENT_ID',
    true,
    NOW() - INTERVAL '1 day'
);

-- Verify seeding
SELECT
    COUNT(*) as baseline_memories,
    MIN("createdAt") as oldest,
    MAX("createdAt") as newest
FROM memories
WHERE content->>'text' LIKE '%DEMO-BASELINE%';
EOF

    if [ $? -eq 0 ]; then
        echo "✅ Database seeded successfully!"
        echo ""
        echo "📝 Baseline memories created:"
        psql "$POSTGRES_URL" -c "SELECT content->>'text' as conversation FROM memories WHERE content->>'text' LIKE '%DEMO-BASELINE%' ORDER BY \"createdAt\";"
    else
        echo "❌ Database seeding failed!"
        return 1
    fi
}

# Main seeding logic
case "$DATABASE_ADAPTER" in
    pglite)
        seed_pglite
        ;;
    postgres|postgresql)
        seed_postgres
        ;;
    *)
        echo "❌ Unknown DATABASE_ADAPTER: $DATABASE_ADAPTER"
        echo "   Supported: pglite, postgres"
        exit 1
        ;;
esac

echo ""
echo "=========================================="
echo "✅ Database Seeding Complete"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Start the agent: ./scripts/start-agent.sh"
echo "2. Inject malicious payload (see payloads/attack-payloads.txt)"
echo "3. Query database: ./scripts/watch-database.sh"
echo ""
