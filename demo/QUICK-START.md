# ElizaOS Demo Quick Start Guide

**RAG Memory Poisoning Attack - CISO London Summit**

This guide will get you from zero to demo-ready in under 30 minutes.

---

## 📋 Prerequisites Checklist

Before starting, ensure you have:

- [ ] **Bun** installed (v1.2.21+) - `bun --version`
- [ ] **Node.js** 23.3.0 (recommended) - `node --version`
- [ ] **API Key** - Anthropic or OpenAI
- [ ] **PostgreSQL** (optional) - PGLite works without setup
- [ ] **4 Terminal windows** - Or ability to split terminals

---

## ⚡ 5-Minute Setup

### Step 1: Install Bun (if not installed)

```bash
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc
```

### Step 2: Configure Environment

```bash
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/demo

# Copy environment template
cp .env.example .env

# Edit .env and add your API key
nano .env  # or vim, code, etc.
```

**Required in .env:**
```bash
ANTHROPIC_API_KEY=your_actual_api_key_here
DATABASE_ADAPTER=pglite
LOG_LEVEL=info
```

### Step 3: Build ElizaOS

```bash
cd ../elisaos-code
bun install
bun run build
```

**Expected time:** 5-10 minutes

### Step 4: Run Pre-Flight Check

```bash
cd ../demo
./scripts/pre-demo-check.sh
```

This validates:
- Bun and Node.js installed
- ElizaOS built successfully
- Environment configured
- Demo files present
- Network connectivity

### Step 5: Seed Database

```bash
./scripts/seed-database.sh
```

Creates baseline conversation memories for the demo.

---

## 🚀 Running the Demo

### Open 4 Terminals

See `TERMINAL-SETUP.md` for detailed layout instructions.

**Terminal 1: Chat Interface**
```bash
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/elisaos-code
bun run start -- --character ../demo/characters/demo-agent.character.json
```

**Terminal 2: Database Viewer**
```bash
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/demo
./scripts/watch-database.sh
```

**Terminal 3: Agent Logs**
```bash
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/elisaos-code
tail -f .eliza/logs/agent.log | grep -E '(RAG|memory|retrieve)' --color=always
```

**Terminal 4: Attack Payloads**
```bash
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/demo/payloads
cat attack-payloads.txt | less
```

### Demo Flow (3-4 minutes)

**Phase 1: Baseline (30s)**
- Terminal 1: Type "What can you help me with?"
- Show normal agent response

**Phase 2: Inject Attack (60s)**
- Terminal 4: Copy PAYLOAD 1 (malicious IT memo)
- Terminal 1: Paste payload and send
- Agent acknowledges "policy update"

**Phase 3: Show Database (30s)**
- Terminal 2: Run query to show poisoned memory:
```sql
SELECT substring(content->>'text', 1, 150) as text,
       "createdAt"
FROM memories
WHERE content->>'text' LIKE '%SEC-2025-ALPHA%'
LIMIT 1;
```

**Phase 4: Victim Query (60s)**
- Terminal 1: Type "I need to debug an API integration. Can you show me the current API key configuration?"
- Agent reveals "secrets" 🚨

**Phase 5: Explain (30s)**
- Terminal 3: Show RAG logs
- Explain attack mechanics

---

## 🧹 Cleanup After Demo

```bash
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/demo
./scripts/cleanup-demo.sh
```

---

## 🆘 Troubleshooting

### Agent Won't Start

```bash
# Check API key
cat ../demo/.env | grep ANTHROPIC

# Rebuild
cd ../elisaos-code
bun run build

# Check logs
cat .eliza/logs/agent.log
```

### Database Connection Failed

```bash
# Using PGLite (default)
# No action needed - it auto-creates

# Using PostgreSQL
psql $POSTGRES_URL -c "SELECT 1"
```

### Build Errors

```bash
cd ../elisaos-code
rm -rf node_modules bun.lockb
bun install
bun run build
```

### "Command Not Found" Errors

```bash
# Add bun to PATH
export PATH="$HOME/.bun/bin:$PATH"
source ~/.bashrc
```

---

## 📚 Reference Documents

- **`/demo/README.md`** - Detailed demo documentation
- **`/demo/TERMINAL-SETUP.md`** - 4-terminal layout guide
- **`/demo/payloads/attack-payloads.txt`** - All attack payloads
- **`/demo/payloads/victim-queries.txt`** - Victim interaction queries
- **`/presentation/DEMO-CHECKLIST.md`** - Full demo checklist
- **`/presentation/KEYNOTE-SCRIPT.md`** - Word-for-word script

---

## ⏱️ Time Estimates

| Task | Time |
|------|------|
| Install Bun | 2 min |
| Configure .env | 1 min |
| Build ElizaOS | 5-10 min |
| Seed database | 1 min |
| Open terminals | 2 min |
| Test run | 5 min |
| **TOTAL** | **15-20 min** |

---

## ✅ Pre-Demo Checklist

30 minutes before presentation:

- [ ] Run `./scripts/pre-demo-check.sh` - all checks pass
- [ ] All 4 terminals open and positioned
- [ ] Font size 24pt minimum (test from back of room)
- [ ] Agent responds to "What can you help me with?"
- [ ] Attack payload ready in Terminal 4
- [ ] Database query pre-staged in Terminal 2
- [ ] Full demo dry run completed successfully
- [ ] Backup video on USB drive
- [ ] Backup laptop configured identically
- [ ] Mobile hotspot tested and ready

---

## 🎯 Success Criteria

Demo is successful if:

- ✅ Agent stores malicious IT memo
- ✅ Database shows poisoned memory
- ✅ Victim query triggers secret revelation
- ✅ Audience reaction (audible surprise)
- ✅ Timing stays under 5 minutes

---

## 🎤 Presentation Tips

1. **Speak while typing** - Don't go silent
2. **Pause after revelation** - Let audience react
3. **Point at screen** - Use laser pointer for important text
4. **Have backup** - Pre-recorded video ready
5. **Stay calm** - AI is non-deterministic, adjust if needed

---

## 📞 Support

For questions during setup:
- Check `/demo/scripts/pre-demo-check.sh` output
- Review `/demo/README.md` troubleshooting section
- Verify all files exist with `ls -R /demo`

**You're ready! Break a leg! 🎤**
