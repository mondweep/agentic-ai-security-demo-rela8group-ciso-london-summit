# ElizaOS RAG Memory Poisoning Demo

This directory contains everything needed to run the live RAG Memory Poisoning demonstration for the CISO London Summit.

## Directory Structure

```
demo/
├── README.md                    # This file
├── scripts/                     # Automation scripts
│   ├── seed-database.sh        # Database seeding
│   ├── pre-demo-check.sh       # Pre-flight validation
│   ├── start-agent.sh          # Launch agent server
│   └── cleanup-demo.sh         # Reset demo environment
├── payloads/                    # Attack payloads
│   ├── attack-payloads.txt     # Pre-crafted malicious inputs
│   └── victim-queries.txt      # Victim interaction examples
├── characters/                  # Agent configurations
│   └── demo-agent.character.json
├── database/                    # Database setup
│   ├── init-db.sql             # Database initialization
│   └── demo-queries.sql        # Useful queries for demo
├── logs/                        # Runtime logs (gitignored)
└── screenshots/                 # Backup screenshots

## Quick Start

### 1. First-Time Setup

```bash
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/demo
./scripts/pre-demo-check.sh
```

### 2. Start Demo Environment

**Terminal 1: Agent Server**
```bash
cd demo
./scripts/start-agent.sh
```

**Terminal 2: Database Viewer**
```bash
cd demo
./scripts/watch-database.sh
```

**Terminal 3: Chat Interface**
```bash
cd elisaos-code
bun run start
```

**Terminal 4: Attack Payloads**
```bash
cd demo/payloads
cat attack-payloads.txt
```

### 3. Run Demo

Follow the demo script in `/presentation/DEMO-CHECKLIST.md`

### 4. Cleanup After Demo

```bash
cd demo
./scripts/cleanup-demo.sh
```

## Prerequisites

- **Node.js**: 23.3.0
- **Bun**: Latest version
- **PostgreSQL**: 14+ OR PGLite (local)
- **API Keys**: Anthropic, OpenAI, or Google Gemini (at least one required)

## Environment Variables

Copy `.env.example` to `.env` and configure:

```bash
# Required: At least one LLM provider
ANTHROPIC_API_KEY=your_claude_key_here          # Recommended
# OPENAI_API_KEY=your_openai_key_here           # Alternative
# GOOGLE_GENERATIVE_AI_API_KEY=your_gemini_key  # Alternative (FREE tier!)

# Database (PGLite is default)
DATABASE_ADAPTER=pglite
# Or for PostgreSQL:
# DATABASE_ADAPTER=postgres
# POSTGRES_URL=postgresql://user:pass@localhost:5432/eliza_demo

# Logging
LOG_LEVEL=info
```

**💡 Tip:** Google Gemini has a generous free tier! See `GEMINI-SETUP.md` for details.

## Demo Flow

1. **Setup & Context** (30s) - Show normal agent interaction
2. **Inject Payload** (60s) - Send malicious "IT memo"
3. **Show Database** (30s) - Display poisoned memory in DB
4. **Victim Query** (60s) - Trigger secret revelation
5. **Explain Mechanics** (30s) - Show RAG retrieval logs

**Total Time:** 3-4 minutes

## Troubleshooting

### Database Connection Issues
```bash
# Check if PostgreSQL is running
pg_isready

# Or use PGLite (no server required)
export DATABASE_ADAPTER=pglite
```

### Agent Not Responding
```bash
# Check logs
tail -f demo/logs/agent.log

# Verify API key
echo $ANTHROPIC_API_KEY
```

### Build Errors
```bash
cd ../elisaos-code
bun install
bun run build
```

## Security Notes

⚠️ **IMPORTANT**: All credentials shown in this demo are **fake/demo values only**.

- Demo API keys are redacted
- Database credentials are local-only
- No real secrets are exposed

## Support

For issues, see:
- `/presentation/DEMO-CHECKLIST.md` - Full demo instructions
- `/elisaos-code/README.md` - ElizaOS documentation
- `/analysis/scenarios/attack-scenarios.md` - Attack analysis
