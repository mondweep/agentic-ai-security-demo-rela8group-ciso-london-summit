# RAG Memory Poisoning Diagrams - Download Instructions

## 📊 Available Diagrams (8 Total)

All diagrams are available in multiple formats for your keynote presentation:

1. **01-attack-flow-sequence** - Complete attack timeline from injection to credential theft
2. **02-system-architecture** - ElizaOS components and attack surface visualization
3. **03-rag-retrieval** - RAG retrieval mechanism showing vector similarity
4. **04-maestro-framework** - MAESTRO 7-layer security framework
5. **05-attack-vectors** - Attack techniques, vulnerabilities, and impact mind map
6. **06-defense-mechanisms** - 4-layer defense strategy
7. **07-roi-analysis** - Investment vs prevented losses
8. **08-technical-deepdive** - Complete technical flow with decision points

---

## 🖼️ How to Download as PNG

### Method 1: Browser Right-Click (Easiest)

1. **Open HTML file:**
   - Navigate to `presentation/diagrams/` folder
   - Double-click any `.html` file (e.g., `01-attack-flow-sequence.html`)
   - Diagram will render in your browser

2. **Save as PNG:**
   - Right-click directly on the diagram
   - Select "Save image as..." or "Copy image"
   - Choose location and save

3. **For high resolution:**
   - Press `Ctrl/Cmd +` to zoom in 150-200%
   - Then right-click and save
   - Result: Higher DPI image for presentations

### Method 2: Browser Screenshot (Best Quality)

1. **Open HTML file** in Chrome/Edge/Firefox
2. **Press F12** to open DevTools
3. **Press Ctrl/Cmd + Shift + P** (Command Palette)
4. **Type "screenshot"** and select:
   - "Capture full size screenshot" (entire page)
   - "Capture node screenshot" (select SVG element)
5. **Image saves** automatically to Downloads folder

### Method 3: Online Mermaid Editor

1. **Go to:** https://mermaid.live/
2. **Copy content** from any `.mmd` file
3. **Paste** into the editor
4. **Click "Actions"** → "Export PNG" or "Export SVG"
5. **Download** high-resolution image

### Method 4: VS Code Extension (For Developers)

1. **Install:** "Markdown Preview Mermaid Support" extension
2. **Open:** Any `.mmd` file
3. **Preview:** Right-click → "Open Preview"
4. **Export:** Right-click diagram → "Save image"

---

## 📁 File Formats Available

| Format | File Extension | Best For | Location |
|--------|---------------|----------|----------|
| **Mermaid Source** | `.mmd` | Editing, version control | All 8 files |
| **HTML (Interactive)** | `.html` | Browser viewing, export | All 8 files |
| **PNG (Ready to use)** | `.png` | Presentations, documents | Generate yourself |
| **SVG (Vector)** | `.svg` | Print, scaling | Export from HTML |

---

## 🎨 Diagram Specifications

### Visual Design
- **Theme:** Professional white background
- **Colors:**
  - Red (#ff6b6b) - Vulnerabilities/Attacks
  - Yellow (#ffd93d) - Warnings/Affected Areas
  - Green (#6bcf7f) - Defenses/Solutions
- **Font:** Arial, 18px (readable from 20+ feet)
- **Resolution:** 2400x1600px recommended for presentations

### File Sizes (Approximate)
- HTML: ~3-5 KB each
- PNG: ~200-500 KB each (depends on complexity)
- SVG: ~10-30 KB each (vector format)

---

## 💡 Usage Tips

### For PowerPoint/Keynote
1. **Use PNG** for maximum compatibility
2. **Export at 2x zoom** for retina displays
3. **Test readability** from back of room
4. **Add white border** if background isn't pure white

### For Printed Handouts
1. **Use SVG** for print quality
2. **Convert to PDF** for professional printing
3. **300 DPI minimum** for handouts
4. **Consider B&W version** for cost savings

### For Web/Digital
1. **Use SVG** for responsive scaling
2. **Optimize PNG** with tools like TinyPNG
3. **Provide alt text** for accessibility
4. **Link to interactive HTML** for exploration

---

## 🚀 Quick Export Script

If you want to batch export all diagrams:

### Using Chrome Headless (requires Chrome installed)

```bash
# Navigate to diagrams folder
cd presentation/diagrams/

# Export all HTML files to PNG
for file in *.html; do
    google-chrome --headless --screenshot="$file.png" --window-size=2400,1600 "$file"
done
```

### Using Firefox Screenshot

```bash
# Navigate to diagrams folder
cd presentation/diagrams/

# Export using Firefox
for file in *.html; do
    firefox --screenshot "$file.png" "file://$(pwd)/$file"
done
```

---

## 📋 Checklist for Keynote Preparation

- [ ] Export all 8 diagrams to PNG
- [ ] Test visibility on presentation screen (font size 18pt+)
- [ ] Create backups in multiple formats (PNG + SVG)
- [ ] Add to PowerPoint/Keynote slides
- [ ] Print 2-3 copies for handouts
- [ ] Test projector resolution (1920x1080 minimum)
- [ ] Have HTML files ready for live demo (if needed)
- [ ] Save to USB drive as backup

---

## 🎯 Recommended Diagram Usage in Keynote

| Slide Section | Recommended Diagram | Duration |
|--------------|---------------------|----------|
| **Opening: The Threat** | 01-attack-flow-sequence | 2 min |
| **Technical Deep-Dive** | 02-system-architecture | 3 min |
| **How RAG Works** | 03-rag-retrieval | 2 min |
| **Framework Context** | 04-maestro-framework | 1 min |
| **Attack Landscape** | 05-attack-vectors | 2 min |
| **Defense Strategy** | 06-defense-mechanisms | 3 min |
| **Business Case** | 07-roi-analysis | 2 min |
| **Q&A Reference** | 08-technical-deepdive | On demand |

**Total:** 15 minutes with all diagrams

---

## 🛠️ Troubleshooting

### "Diagram not rendering in HTML"
- **Check internet connection** (loads mermaid.js from CDN)
- **Try different browser** (Chrome/Edge work best)
- **Disable ad blockers** (may block CDN)

### "Image quality is poor"
- **Zoom to 200%** before saving
- **Use SVG format** instead of PNG
- **Export at higher resolution** (3000x2000px)

### "Colors don't match presentation theme"
- **Edit `.mmd` files** - change color codes
- **Use image editing software** to adjust
- **Convert to grayscale** if needed

### "File too large for email"
- **Optimize PNG** with TinyPNG.com
- **Use SVG** (10x smaller than PNG)
- **Share via cloud link** (Google Drive, Dropbox)

---

## 📧 Sharing with Team

### Via Email
```
Subject: RAG Memory Poisoning Diagrams - CISO Summit

Hi team,

Attached are the 8 diagrams for the keynote presentation:

1. Attack Flow Sequence - Shows complete attack timeline
2. System Architecture - ElizaOS components and attack surface
3. RAG Retrieval - How vector similarity enables attacks
4. MAESTRO Framework - 7-layer security model
5. Attack Vectors - Mind map of techniques and impact
6. Defense Mechanisms - 4-layer protection strategy
7. ROI Analysis - Business case for security investment
8. Technical Deep-Dive - Complete flow with decision points

All diagrams available in PNG (presentations) and SVG (print quality).

HTML files included for interactive exploration.

Best regards
```

### Via Cloud Storage
1. **Upload folder** to Google Drive/Dropbox
2. **Set permissions** to "Anyone with link can view"
3. **Share link** with presentation team
4. **Include README.md** for instructions

---

## 🎓 Additional Resources

### Mermaid Documentation
- Official docs: https://mermaid.js.org/
- Live editor: https://mermaid.live/
- Syntax guide: https://mermaid.js.org/intro/syntax-reference.html

### Design Resources
- Color picker: https://coolors.co/
- Icon libraries: https://fontawesome.com/
- Font pairing: https://fontpair.co/

### Export Tools
- SVG to PNG: https://cloudconvert.com/svg-to-png
- Image optimizer: https://tinypng.com/
- PDF converter: https://smallpdf.com/

---

## 📞 Support

**Issues with diagrams?**
- Check GitHub repository: [Link at booth #47]
- Visit booth during breaks
- Schedule technical consultation
- Contact via conference app

---

**Created:** October 2025
**Conference:** CISO London Summit
**Location:** `/presentation/diagrams/`
**Total Files:** 24 (8 .mmd + 8 .html + README + script)

**Ready to present! 🚀**
