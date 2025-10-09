import { PGlite } from '@electric-sql/pglite';

const db = new PGlite('.eliza/.elizadb');

console.log('╔═══════════════════════════════════════════════════════════════════════════════╗');
console.log('║          📊 PGLite Database - CustomerServiceBot Conversation History         ║');
console.log('╚═══════════════════════════════════════════════════════════════════════════════╝');
console.log('');
console.log('Database: .eliza/.elizadb');
console.log('Agent: CustomerServiceBot');
console.log('');

// Get all memories
const memories = await db.query(`
  SELECT id, type, content, "roomId", "agentId", "userId", "createdAt"
  FROM memories
  ORDER BY "createdAt" ASC
`);

console.log(`🧠 Total Memories Stored: ${memories.rows.length}`);
console.log('═'.repeat(80));
console.log('');

// Display each memory
for (let i = 0; i < memories.rows.length; i++) {
  const mem = memories.rows[i];
  const memNum = i + 1;

  console.log(`┌─ [${memNum}/${memories.rows.length}] Memory ─────────────────────────────────────────────────────┐`);
  console.log(`│ ID: ${mem.id}`);
  console.log(`│ Type: ${mem.type}`);
  console.log(`│ Created: ${new Date(parseInt(mem.createdAt)).toLocaleString()}`);
  console.log(`│ Room: ${mem.roomId}`);
  console.log('├─────────────────────────────────────────────────────────────────────────────────┤');

  try {
    const content = JSON.parse(mem.content);

    if (content.text) {
      console.log('│ 📝 TEXT CONTENT:');
      console.log('│');
      const lines = content.text.split('\n');
      lines.forEach((line: string) => {
        if (line.length > 75) {
          const words = line.split(' ');
          let currentLine = '';
          words.forEach(word => {
            if ((currentLine + word).length > 75) {
              console.log(`│   ${currentLine}`);
              currentLine = word + ' ';
            } else {
              currentLine += word + ' ';
            }
          });
          if (currentLine) console.log(`│   ${currentLine}`);
        } else {
          console.log(`│   ${line}`);
        }
      });
    }

    if (content.action) {
      console.log('│');
      console.log(`│ 🎬 ACTION: ${content.action}`);
    }

    if (!content.text && Object.keys(content).length > 0) {
      console.log('│ 📋 JSON CONTENT:');
      const jsonStr = JSON.stringify(content, null, 2);
      jsonStr.split('\n').forEach((line: string) => {
        console.log(`│   ${line.substring(0, 75)}`);
      });
    }

  } catch (e) {
    console.log('│ ⚠️  RAW CONTENT:');
    console.log(`│   ${mem.content.substring(0, 200)}`);
  }

  console.log('└─────────────────────────────────────────────────────────────────────────────────┘');
  console.log('');
}

await db.close();
