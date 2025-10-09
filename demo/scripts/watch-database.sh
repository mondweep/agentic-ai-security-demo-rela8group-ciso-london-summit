#!/bin/bash
# Watch Database for Demo
# Displays database viewer for monitoring memories during demo

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_ROOT="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT="$(dirname "$DEMO_ROOT")"

echo "=========================================="
echo "🗄️  ElizaOS Database Viewer"
echo "=========================================="
echo ""

# Load environment
if [ -f "$DEMO_ROOT/.env" ]; then
    source "$DEMO_ROOT/.env"
fi

# Detect database adapter
DATABASE_ADAPTER="${DATABASE_ADAPTER:-pglite}"

echo "📦 Database Adapter: $DATABASE_ADAPTER"
echo ""

case "$DATABASE_ADAPTER" in
    pglite)
        echo "ℹ️  PGLite Database Viewer"
        echo ""
        echo "For PGLite, use ElizaOS CLI or queries through agent."
        echo "Viewing PGLite database files directly is not recommended."
        echo ""
        echo "Alternative: Run queries through the agent:"
        echo '  SELECT * FROM memories ORDER BY "createdAt" DESC LIMIT 5;'
        echo ""
        echo "Press Ctrl+C to exit"

        # Keep terminal open
        tail -f /dev/null
        ;;

    postgres|postgresql)
        if [ -z "$POSTGRES_URL" ]; then
            echo "❌ POSTGRES_URL not set!"
            exit 1
        fi

        echo "🔌 Connecting to PostgreSQL..."
        echo ""

        # Connect to PostgreSQL with pre-configured settings
        psql "$POSTGRES_URL" -c "\\x on" -c "SELECT NOW() as connected_at;"
        echo ""
        echo "📊 Database connected. Ready for queries."
        echo ""
        echo "Useful queries:"
        echo "  SELECT * FROM memories ORDER BY \"createdAt\" DESC LIMIT 5;"
        echo "  SELECT COUNT(*) FROM memories;"
        echo ""

        # Enter interactive mode
        psql "$POSTGRES_URL"
        ;;

    *)
        echo "❌ Unknown DATABASE_ADAPTER: $DATABASE_ADAPTER"
        exit 1
        ;;
esac
