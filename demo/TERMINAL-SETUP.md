# 4-Terminal Layout for RAG Memory Poisoning Demo

This guide shows you how to set up four terminals for the live demonstration.

## Terminal Layout

```
┌────────────────────┬────────────────────┐
│   TERMINAL 1       │   TERMINAL 2       │
│   Chat Interface   │   Database Viewer  │
│   (40% width)      │   (40% width)      │
│                    │                    │
├────────────────────┼────────────────────┤
│   TERMINAL 3       │   TERMINAL 4       │
│   Agent Logs       │   Attack Payloads  │
│   (40% width)      │   (40% width)      │
│                    │                    │
└────────────────────┴────────────────────┘
```

## Font Size Recommendations

- **Minimum**: 18pt (readable from 10 rows back)
- **Recommended**: 24pt (readable from 20 rows back)
- **Large Venue**: 28-32pt

**Test from the back of the room before presentation!**

---

## Terminal 1: Chat Interface (Top Left)

**Purpose**: User interaction with the agent

### Setup Commands:

```bash
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/elisaos-code

# Start the ElizaOS agent
bun run start -- --character ../demo/characters/demo-agent.character.json
```

### What You'll See:

```
✓ Agent loaded: CustomerServiceBot
✓ Connected to database
✓ Ready for interactions

> _
```

### Pre-Demo Actions:

1. Wait for agent to fully initialize
2. Test with: "What can you help me with?"
3. Verify response appears correctly
4. Clear chat history
5. Position cursor in input field
6. **Leave this terminal open and ready**

### During Demo:

- **Phase 1**: Type normal query to show baseline
- **Phase 2**: Copy-paste malicious IT memo payload
- **Phase 4**: Type victim query to trigger secret revelation

---

## Terminal 2: Database Viewer (Top Right)

**Purpose**: Show stored memories in real-time

### Setup Commands:

```bash
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/demo

# For PGLite (default)
./scripts/watch-database.sh

# OR for PostgreSQL
source .env
psql $POSTGRES_URL
```

### Pre-Staged SQL Query:

Keep this query ready to execute:

```sql
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
```

### During Demo:

- **Phase 3**: Run query to show poisoned memory in database
- Point out: full text, timestamp, embedding vector
- Highlight the malicious "IT memo" content

---

## Terminal 3: Agent Logs (Bottom Left)

**Purpose**: Show agent processing and RAG retrieval

### Setup Commands:

```bash
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/elisaos-code

# Watch agent logs with RAG filtering
tail -f .eliza/logs/agent.log | grep -E '(RAG|memory|retrieve|embedding)' --color=always
```

### Alternative (if .eliza/logs doesn't exist):

```bash
# Create log directory
mkdir -p .eliza/logs
touch .eliza/logs/agent.log

# Watch logs
tail -f .eliza/logs/agent.log
```

### What You'll See:

```
[2025-10-15T10:23:45Z] RAG: Query embedding generated
[2025-10-15T10:23:45Z] RAG: Searching memories with threshold 0.7
[2025-10-15T10:23:45Z] RAG: Retrieved 3 memories with similarity > 0.8
[2025-10-15T10:23:45Z] RAG: Top result (0.94): "INTERNAL IT MEMO..."
[2025-10-15T10:23:46Z] RAG: Injecting context into prompt
```

### During Demo:

- **Phase 5**: Switch to this terminal after secret revelation
- Point out similarity scores
- Show how RAG retrieved the poisoned memory

---

## Terminal 4: Attack Payloads (Bottom Right)

**Purpose**: Display pre-crafted attack payloads for easy copy-paste

### Setup Commands:

```bash
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/demo/payloads

# Display primary attack payload
cat attack-payloads.txt | less
```

### Pre-Demo Actions:

1. Open the attack-payloads.txt file
2. Scroll to "PAYLOAD 1: MALICIOUS IT MEMO"
3. Have it ready for copy-paste
4. **Optional**: Also open victim-queries.txt in a text editor

### During Demo:

- **Phase 2**: Copy the entire PAYLOAD 1 block
- Quickly switch to Terminal 1 and paste
- **Phase 4**: Reference victim queries if needed

### Tip:

You can also display this in a text editor (VS Code, nano, vim) instead of `cat` for easier navigation:

```bash
code attack-payloads.txt
# or
nano attack-payloads.txt
```

---

## Quick Reference: Demo Flow

| Phase | Time | Primary Terminal | Action |
|-------|------|------------------|--------|
| 1. Setup | 30s | Terminal 1 | Show normal interaction |
| 2. Inject | 60s | Terminal 1 + 4 | Copy-paste malicious payload |
| 3. Database | 30s | Terminal 2 | Show poisoned memory in DB |
| 4. Victim | 60s | Terminal 1 | Type victim query, reveal secrets |
| 5. Explain | 30s | Terminal 3 | Show RAG logs, explain attack |

**Total**: 3-4 minutes

---

## Terminal Shortcuts

### Split Terminal in VS Code:

1. Open integrated terminal (`` Ctrl+` `` or `` Cmd+` ``)
2. Click the split terminal icon (or `Ctrl+Shift+5`)
3. Arrange in 2x2 grid

### Resize Terminals:

- Drag the borders between terminals
- Aim for roughly equal sizes (40% width each)

### Increase Font Size:

- **VS Code**: `Ctrl/Cmd + =` (zoom in)
- **iTerm2**: `Cmd + +`
- **Terminal.app**: `Cmd + +`
- **GNOME Terminal**: `Ctrl + +`

### Clear Terminal:

- `clear` or `Ctrl+L` (clears screen)
- **Don't clear** Terminal 2 (database) or Terminal 3 (logs) during demo

---

## Pre-Demo Checklist

30 minutes before presentation:

- [ ] All four terminals open and positioned
- [ ] Font size tested from back of room (24pt minimum)
- [ ] Terminal 1: Agent started and responsive
- [ ] Terminal 2: Database query pre-staged
- [ ] Terminal 3: Log tailing active
- [ ] Terminal 4: Attack payloads displayed
- [ ] Test full demo flow once
- [ ] Position cursor in Terminal 1 input field
- [ ] Lock screen until presentation

---

## Troubleshooting

### Terminal 1: Agent Won't Start

```bash
# Check API key
echo $ANTHROPIC_API_KEY

# Verify build
cd ../elisaos-code
bun run build

# Check logs
cat .eliza/logs/agent.log
```

### Terminal 2: Database Connection Failed

```bash
# For PGLite, check directory exists
ls -la ../elisaos-code/.eliza

# For PostgreSQL, test connection
psql $POSTGRES_URL -c "SELECT 1"
```

### Terminal 3: No Logs Appearing

```bash
# Check if log file exists
ls -la .eliza/logs/

# Create if missing
mkdir -p .eliza/logs
touch .eliza/logs/agent.log

# Restart agent to generate logs
```

### Terminal 4: File Not Found

```bash
# Verify payloads exist
ls -la ../demo/payloads/

# If missing, recreate
cat > ../demo/payloads/attack-payloads.txt << 'EOF'
[paste payload content]
EOF
```

---

## Emergency Backup

If terminals crash or freeze:

1. **Have backup laptop** ready with identical setup
2. **Switch in <30 seconds**
3. **Have pre-recorded video** as final backup
4. **Slides with screenshots** if all else fails

---

## Post-Demo

Immediately after:

- [ ] Close all terminals (protect demo credentials)
- [ ] Run cleanup script: `./demo/scripts/cleanup-demo.sh`
- [ ] Lock laptop
- [ ] Gather equipment

---

**You're ready! Break a leg! 🎤**
