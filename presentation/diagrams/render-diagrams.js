#!/usr/bin/env node

/**
 * Mermaid to SVG/PNG Renderer
 * Converts mermaid diagrams to downloadable images
 */

const fs = require('fs');
const path = require('path');

// Create HTML files that can be opened in browser to export
const diagrams = [
  '01-attack-flow-sequence',
  '02-system-architecture',
  '03-rag-retrieval',
  '04-maestro-framework',
  '05-attack-vectors',
  '06-defense-mechanisms',
  '07-roi-analysis',
  '08-technical-deepdive'
];

const htmlTemplate = (diagramName, mermaidCode) => `<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${diagramName}</title>
    <script type="module">
        import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
        mermaid.initialize({
            startOnLoad: true,
            theme: 'default',
            securityLevel: 'loose',
            themeVariables: {
                fontSize: '18px',
                fontFamily: 'Arial, sans-serif'
            }
        });
    </script>
    <style>
        body {
            margin: 0;
            padding: 40px;
            background: white;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        #diagram {
            max-width: 100%;
        }
        .instructions {
            position: fixed;
            top: 10px;
            right: 10px;
            background: #f0f0f0;
            padding: 15px;
            border-radius: 8px;
            font-family: monospace;
            font-size: 12px;
            max-width: 300px;
        }
    </style>
</head>
<body>
    <div class="instructions">
        <strong>To save as PNG:</strong><br/>
        1. Right-click on diagram<br/>
        2. "Save image as..." or "Copy image"<br/>
        3. Or use browser DevTools to export SVG<br/>
        <br/>
        <strong>For high-quality:</strong><br/>
        Press Ctrl/Cmd + to zoom, then save
    </div>
    <div id="diagram">
        <pre class="mermaid">
${mermaidCode}
        </pre>
    </div>
</body>
</html>`;

console.log('Creating HTML files for browser-based rendering...\n');

diagrams.forEach(diagramName => {
    const mmdFile = path.join(__dirname, `${diagramName}.mmd`);
    const htmlFile = path.join(__dirname, `${diagramName}.html`);

    if (fs.existsSync(mmdFile)) {
        const mermaidCode = fs.readFileSync(mmdFile, 'utf8');
        const html = htmlTemplate(diagramName, mermaidCode);
        fs.writeFileSync(htmlFile, html);
        console.log(`✅ Created: ${diagramName}.html`);
    } else {
        console.log(`❌ Missing: ${mmdFile}`);
    }
});

console.log('\n📋 Instructions:');
console.log('1. Open each .html file in your browser');
console.log('2. Right-click on the diagram');
console.log('3. Select "Save image as..." to download PNG');
console.log('4. Or press Ctrl/Cmd+Shift+S to take screenshot\n');

console.log('📁 Files created in: presentation/diagrams/\n');
