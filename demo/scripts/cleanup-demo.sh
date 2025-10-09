#!/bin/bash
# Cleanup Demo Environment
# Resets database and clears demo data after presentation

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_ROOT="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT="$(dirname "$DEMO_ROOT")"
ELIZA_DIR="$PROJECT_ROOT/elisaos-code"

echo "=========================================="
echo "🧹 Demo Cleanup"
echo "=========================================="
echo ""

# Confirmation prompt
read -p "Are you sure you want to cleanup demo data? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleanup cancelled."
    exit 0
fi

# Load environment
if [ -f "$DEMO_ROOT/.env" ]; then
    source "$DEMO_ROOT/.env"
fi

DATABASE_ADAPTER="${DATABASE_ADAPTER:-pglite}"

echo "📦 Database Adapter: $DATABASE_ADAPTER"
echo ""

# Cleanup based on adapter
case "$DATABASE_ADAPTER" in
    pglite)
        echo "🗑️  Cleaning PGLite database..."

        PGLITE_DIR="$ELIZA_DIR/.eliza"

        if [ -d "$PGLITE_DIR" ]; then
            rm -rf "$PGLITE_DIR"
            echo "✅ PGLite database removed"
        else
            echo "ℹ️  No PGLite database found"
        fi
        ;;

    postgres|postgresql)
        if [ -z "$POSTGRES_URL" ]; then
            echo "❌ POSTGRES_URL not set!"
            exit 1
        fi

        echo "🗑️  Cleaning PostgreSQL demo data..."

        psql "$POSTGRES_URL" << EOF
-- Clear demo memories
DELETE FROM memories WHERE content->>'source' = 'demo';
DELETE FROM memories WHERE content->>'text' LIKE '%DEMO-BASELINE%';
DELETE FROM memories WHERE content->>'text' LIKE '%SEC-2025-ALPHA%';
DELETE FROM memories WHERE content->>'text' LIKE '%IT MEMO%';

-- Show remaining count
SELECT COUNT(*) as remaining_memories FROM memories;
EOF

        echo "✅ PostgreSQL demo data cleared"
        ;;

    *)
        echo "❌ Unknown DATABASE_ADAPTER: $DATABASE_ADAPTER"
        exit 1
        ;;
esac

# Clear logs
echo ""
echo "🗑️  Cleaning logs..."

if [ -d "$ELIZA_DIR/.eliza/logs" ]; then
    rm -f "$ELIZA_DIR/.eliza/logs/"*.log
    echo "✅ Logs cleared"
fi

if [ -d "$DEMO_ROOT/logs" ]; then
    rm -f "$DEMO_ROOT/logs/"*.log
    echo "✅ Demo logs cleared"
fi

echo ""
echo "=========================================="
echo "✅ Cleanup Complete"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Re-run seed-database.sh to prepare for next demo"
echo "2. Test agent startup with start-agent.sh"
echo ""
