#!/bin/bash
# Pre-Demo Validation Script
# Run 30 minutes before presentation to verify all systems are ready

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_ROOT="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT="$(dirname "$DEMO_ROOT")"
ELIZA_DIR="$PROJECT_ROOT/elisaos-code"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo ""
echo "=========================================="
echo "🎤 CISO Summit Demo Pre-Flight Check"
echo "=========================================="
echo ""

CHECKS_PASSED=0
CHECKS_FAILED=0
CHECKS_WARNING=0

# Helper functions
check_passed() {
    echo -e "${GREEN}✅ $1${NC}"
    ((CHECKS_PASSED++))
}

check_failed() {
    echo -e "${RED}❌ $1${NC}"
    ((CHECKS_FAILED++))
}

check_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
    ((CHECKS_WARNING++))
}

# [1/10] Check Node.js version
echo "[1/10] Checking Node.js version..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    EXPECTED="v23.3.0"
    if [[ "$NODE_VERSION" == "$EXPECTED" ]]; then
        check_passed "Node.js $NODE_VERSION (correct version)"
    else
        check_warning "Node.js $NODE_VERSION (expected $EXPECTED)"
    fi
else
    check_failed "Node.js not found"
fi

# [2/10] Check Bun
echo "[2/10] Checking Bun..."
if command -v bun &> /dev/null; then
    BUN_VERSION=$(bun --version)
    check_passed "Bun v$BUN_VERSION installed"
else
    check_failed "Bun not found - install from https://bun.sh"
fi

# [3/10] Check ElizaOS directory
echo "[3/10] Checking ElizaOS directory..."
if [ -d "$ELIZA_DIR" ]; then
    check_passed "ElizaOS directory found"
else
    check_failed "ElizaOS directory not found at $ELIZA_DIR"
fi

# [4/10] Check if ElizaOS is built
echo "[4/10] Checking if ElizaOS is built..."
if [ -d "$ELIZA_DIR/packages/core/dist" ]; then
    check_passed "ElizaOS packages are built"
else
    check_warning "ElizaOS not built - run 'cd $ELIZA_DIR && bun install && bun run build'"
fi

# [5/10] Check environment variables
echo "[5/10] Checking environment variables..."
ENV_FILE="$DEMO_ROOT/.env"
if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
    check_passed ".env file found"

    if [ -n "$ANTHROPIC_API_KEY" ] || [ -n "$OPENAI_API_KEY" ]; then
        check_passed "API key configured"
    else
        check_failed "No API key found (ANTHROPIC_API_KEY or OPENAI_API_KEY required)"
    fi
else
    check_warning ".env file not found - create from .env.example"
fi

# [6/10] Check database adapter
echo "[6/10] Checking database configuration..."
if [ -z "$DATABASE_ADAPTER" ]; then
    DATABASE_ADAPTER="pglite"
    check_warning "DATABASE_ADAPTER not set, defaulting to pglite"
else
    check_passed "Database adapter: $DATABASE_ADAPTER"
fi

if [ "$DATABASE_ADAPTER" = "postgres" ] || [ "$DATABASE_ADAPTER" = "postgresql" ]; then
    if command -v psql &> /dev/null; then
        check_passed "PostgreSQL client installed"

        if [ -n "$POSTGRES_URL" ]; then
            if psql "$POSTGRES_URL" -c "SELECT 1" &> /dev/null; then
                check_passed "PostgreSQL connection successful"
            else
                check_failed "Cannot connect to PostgreSQL"
            fi
        else
            check_failed "POSTGRES_URL not set"
        fi
    else
        check_failed "PostgreSQL client (psql) not found"
    fi
fi

# [7/10] Check demo character file
echo "[7/10] Checking demo character file..."
CHARACTER_FILE="$DEMO_ROOT/characters/demo-agent.character.json"
if [ -f "$CHARACTER_FILE" ]; then
    check_passed "Demo character file exists"
else
    check_warning "Demo character file not found - will be created"
fi

# [8/10] Check attack payloads
echo "[8/10] Checking attack payloads..."
PAYLOADS_FILE="$DEMO_ROOT/payloads/attack-payloads.txt"
if [ -f "$PAYLOADS_FILE" ]; then
    check_passed "Attack payloads file exists"
else
    check_warning "Attack payloads file not found - will be created"
fi

# [9/10] Check network connectivity
echo "[9/10] Checking network connectivity..."
if ping -c 1 8.8.8.8 &> /dev/null; then
    check_passed "Network connectivity confirmed"
else
    check_warning "Network issues detected - may need mobile hotspot"
fi

# [10/10] Check disk space
echo "[10/10] Checking disk space..."
AVAILABLE_SPACE=$(df -h "$PROJECT_ROOT" | awk 'NR==2 {print $4}')
check_passed "Available disk space: $AVAILABLE_SPACE"

echo ""
echo "=========================================="
echo "📊 Pre-Flight Check Summary"
echo "=========================================="
echo -e "${GREEN}Passed:  $CHECKS_PASSED${NC}"
echo -e "${YELLOW}Warnings: $CHECKS_WARNING${NC}"
echo -e "${RED}Failed:   $CHECKS_FAILED${NC}"
echo ""

# Display test pattern for projector
echo "=========================================="
echo "🖥️  Display Test Pattern"
echo "=========================================="
echo "████████████████████████████████████████"
echo "█                                      █"
echo "█   If you can read this clearly,     █"
echo "█   the display is properly sized.    █"
echo "█                                      █"
echo "████████████████████████████████████████"
echo ""

# Final decision
if [ $CHECKS_FAILED -eq 0 ]; then
    echo "=========================================="
    echo -e "${GREEN}✅ ALL SYSTEMS GO${NC}"
    echo "=========================================="
    echo ""
    echo "Next steps:"
    echo "1. Open four terminals (see demo/TERMINAL-SETUP.md)"
    echo "2. Run demo once for final validation"
    echo "3. Position cursor in chat input"
    echo "4. Lock screen until presentation"
    echo ""
    echo -e "${BLUE}Break a leg! 🎤${NC}"
    exit 0
elif [ $CHECKS_FAILED -le 2 ] && [ $CHECKS_WARNING -ge 0 ]; then
    echo "=========================================="
    echo -e "${YELLOW}⚠️  GO LIVE (with caution)${NC}"
    echo "=========================================="
    echo ""
    echo "Minor issues detected but core functionality should work."
    echo "Review warnings above and address if possible."
    echo ""
    exit 0
else
    echo "=========================================="
    echo -e "${RED}❌ USE BACKUP VIDEO${NC}"
    echo "=========================================="
    echo ""
    echo "Critical failures detected. Live demo is high risk."
    echo "Consider using pre-recorded video instead."
    echo ""
    echo "To fix issues:"
    echo "1. Review failed checks above"
    echo "2. Install missing dependencies"
    echo "3. Configure environment variables"
    echo "4. Re-run this script"
    echo ""
    exit 1
fi
