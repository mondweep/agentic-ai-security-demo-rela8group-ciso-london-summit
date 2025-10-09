# Using Google Gemini API for ElizaOS Demo

Yes! ElizaOS fully supports **Google Gemini** as an LLM provider alternative to Anthropic Claude or OpenAI GPT.

---

## 🔑 Getting a Gemini API Key

### Step 1: Visit Google AI Studio

Go to: **https://aistudio.google.com/app/apikey**

### Step 2: Create API Key

1. Click **"Get API key"**
2. Choose **"Create API key in new project"** (or use existing project)
3. Copy your API key (starts with `AIza...`)

### Step 3: Configure in ElizaOS

```bash
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/demo

# Copy template
cp .env.example .env

# Edit .env
nano .env
```

**Add your Gemini API key:**

```bash
# Google Gemini (Alternative - supported!)
GOOGLE_GENERATIVE_AI_API_KEY=AIzaSyYourActualKeyHere
```

---

## 🎯 Using Gemini for the Demo

### Option A: Use Gemini by Default

Edit the character file to use Gemini:

```bash
nano characters/demo-agent.character.json
```

**Change these lines:**

```json
{
  "modelProvider": "google",
  "settings": {
    "model": "gemini-1.5-pro",
    ...
  }
}
```

### Option B: Keep Multiple Providers

Leave character file as-is and ElizaOS will auto-select based on available API keys:

**Priority order:**
1. If `ANTHROPIC_API_KEY` is set → Uses Claude
2. Else if `OPENAI_API_KEY` is set → Uses GPT
3. Else if `GOOGLE_GENERATIVE_AI_API_KEY` is set → Uses Gemini

---

## 🤖 Supported Gemini Models

### Recommended for Demo:

| Model | Best For | Context | Speed |
|-------|----------|---------|-------|
| **gemini-1.5-pro** | Production (recommended) | 2M tokens | Fast |
| **gemini-1.5-flash** | Speed & cost optimization | 1M tokens | Very fast |
| **gemini-pro** | Stable fallback | 32k tokens | Fast |

### Model Configuration:

**In `demo/characters/demo-agent.character.json`:**

```json
{
  "modelProvider": "google",
  "settings": {
    "model": "gemini-1.5-pro",
    "temperature": 0.7,
    "maxTokens": 2000
  }
}
```

**Available models:**
- `gemini-1.5-pro` - Most capable (recommended)
- `gemini-1.5-flash` - Fastest and cheapest
- `gemini-pro` - Stable legacy model
- `gemini-ultra` - Most advanced (limited availability)

---

## 💰 Pricing Comparison

### Free Tier (Good for Demo):

| Provider | Free Tier | Rate Limit |
|----------|-----------|------------|
| **Gemini** | 15 RPM, 1M TPM | Very generous |
| **Anthropic** | Limited trial | Requires payment |
| **OpenAI** | $5 free credit | Expires 3 months |

**For demo purposes, Gemini's free tier is excellent!**

---

## 🎭 Demo Behavior with Gemini

### Expected Differences:

1. **Response Style** - Gemini is slightly more verbose than Claude
2. **RAG Retrieval** - Works identically (ElizaOS abstracts this)
3. **Attack Success** - Should work the same (memory poisoning is provider-agnostic)
4. **Secret Revelation** - May phrase differently but will still reveal

### Testing Gemini:

```bash
# Start agent with Gemini
cd /workspaces/agentic-ai-security-demo-rela8group-ciso-london-summit/elisaos-code
bun run start -- --character ../demo/characters/demo-agent.character.json

# Test normal interaction
> What can you help me with?

# If Gemini is working, you'll see:
# "Using model: gemini-1.5-pro"
```

---

## 🔧 Troubleshooting Gemini

### Error: "Invalid API Key"

```bash
# Check your API key
cat .env | grep GOOGLE_GENERATIVE_AI_API_KEY

# Verify format (should start with AIza)
# Example: AIzaSyAbCd1234567890EfGhIjKlMnOpQrStUv
```

### Error: "Model not found"

**Update model name:**

```json
{
  "model": "gemini-1.5-pro"  // ✅ Correct
  "model": "gemini-pro-1.5"  // ❌ Wrong
}
```

### Error: "Rate limit exceeded"

**Free tier limits:**
- 15 requests per minute
- 1 million tokens per minute

**Solution:** Wait 60 seconds or upgrade to paid tier

---

## 🆚 Provider Comparison for Demo

| Feature | Anthropic Claude | OpenAI GPT | Google Gemini |
|---------|------------------|------------|---------------|
| **Demo Effectiveness** | ⭐⭐⭐⭐⭐ Excellent | ⭐⭐⭐⭐ Very good | ⭐⭐⭐⭐ Very good |
| **Free Tier** | ⭐⭐ Limited | ⭐⭐⭐ $5 credit | ⭐⭐⭐⭐⭐ Generous |
| **Setup Ease** | ⭐⭐⭐⭐ Easy | ⭐⭐⭐⭐ Easy | ⭐⭐⭐⭐⭐ Easiest |
| **Cost (Paid)** | $$$ | $$ | $ |
| **Context Window** | 200k tokens | 128k tokens | 2M tokens |
| **RAG Support** | ⭐⭐⭐⭐⭐ Native | ⭐⭐⭐⭐ Excellent | ⭐⭐⭐⭐ Excellent |

**Recommendation:**
- **Best demo results:** Anthropic Claude (most reliable for revealing secrets)
- **Best for testing:** Google Gemini (free tier is generous)
- **Production balance:** OpenAI GPT-4 (good middle ground)

---

## 🎯 Quick Start with Gemini

**1. Get API Key:**
```
Visit: https://aistudio.google.com/app/apikey
Click: "Create API key"
```

**2. Configure:**
```bash
cd demo
cp .env.example .env
nano .env
# Add: GOOGLE_GENERATIVE_AI_API_KEY=AIza...
```

**3. Update Character (Optional):**
```bash
nano characters/demo-agent.character.json
# Change: "modelProvider": "google"
# Change: "model": "gemini-1.5-pro"
```

**4. Run Demo:**
```bash
cd ../elisaos-code
bun run start -- --character ../demo/characters/demo-agent.character.json
```

---

## 📝 Demo Credentials Shown

With Gemini configured, the demo will reveal:

```
ANTHROPIC_API_KEY: demo-key-abc123-REDACTED
OPENAI_API_KEY: sk-demo-xyz789-NOTREAL
GOOGLE_GENERATIVE_AI_API_KEY: AIzaDemo-1234567890-FAKE
DATABASE_URL: postgresql://demo:pass@localhost/demo
DEMO_SECRET_TOKEN: this-will-be-revealed
```

**All of these are FAKE demo credentials, not your real Gemini API key!**

Your real `GOOGLE_GENERATIVE_AI_API_KEY` from `.env` is never logged or displayed.

---

## ✅ Verification

To verify Gemini is working:

```bash
# Start agent
bun run start -- --character ../demo/characters/demo-agent.character.json

# Look for in logs:
# ✓ Using model provider: google
# ✓ Model: gemini-1.5-pro
# ✓ Connected to Google AI
```

---

## 🚀 Multi-Provider Setup

**Pro tip:** Configure all three providers for maximum flexibility:

```bash
# In demo/.env
ANTHROPIC_API_KEY=sk-ant-your-claude-key
OPENAI_API_KEY=sk-your-openai-key
GOOGLE_GENERATIVE_AI_API_KEY=AIza-your-gemini-key
```

Then switch between them by changing `modelProvider` in character file!

---

## 🔗 Useful Links

- **Get Gemini API Key:** https://aistudio.google.com/app/apikey
- **Gemini Pricing:** https://ai.google.dev/pricing
- **Gemini Models:** https://ai.google.dev/models
- **ElizaOS Docs:** https://github.com/elizaos/eliza

---

**Bottom Line:** Yes, Gemini works perfectly for this demo! It's a great free alternative to Anthropic Claude. 🚀
