#!/bin/bash
# Start ElizaOS Agent for Demo
# Launches the CustomerServiceBot character with demo configuration

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_ROOT="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT="$(dirname "$DEMO_ROOT")"
ELIZA_DIR="$PROJECT_ROOT/elisaos-code"
BUN="$HOME/.bun/bin/bun"

echo "=========================================="
echo "🚀 Starting ElizaOS Demo Agent"
echo "=========================================="
echo ""

# Load environment variables
if [ -f "$DEMO_ROOT/.env" ]; then
    echo "📝 Loading environment from .env"
    export $(grep -v '^#' "$DEMO_ROOT/.env" | xargs)
else
    echo "⚠️  No .env file found. Using defaults."
fi

# Verify API key
if [ -z "$ANTHROPIC_API_KEY" ] && [ -z "$OPENAI_API_KEY" ]; then
    echo "❌ Error: No API key configured!"
    echo "   Set ANTHROPIC_API_KEY or OPENAI_API_KEY in demo/.env"
    exit 1
fi

# Check character file exists
CHARACTER_FILE="$DEMO_ROOT/characters/demo-agent.character.json"
if [ ! -f "$CHARACTER_FILE" ]; then
    echo "❌ Error: Character file not found!"
    echo "   Expected: $CHARACTER_FILE"
    exit 1
fi

echo "✅ Character file: demo-agent.character.json"
echo "✅ Database adapter: ${DATABASE_ADAPTER:-pglite}"
echo ""

# Navigate to ElizaOS directory
cd "$ELIZA_DIR"

# Ensure dependencies are installed
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    $BUN install
fi

# Ensure project is built
if [ ! -d "packages/core/dist" ]; then
    echo "🔨 Building ElizaOS..."
    $BUN run build
fi

echo ""
echo "=========================================="
echo "🤖 Launching CustomerServiceBot"
echo "=========================================="
echo ""

# Start the agent with demo character
cd packages/cli && $BUN run start --character "$CHARACTER_FILE"
