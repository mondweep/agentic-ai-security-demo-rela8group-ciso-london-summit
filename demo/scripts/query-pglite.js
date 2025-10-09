#!/usr/bin/env node

const { PGlite } = require('@electric-sql/pglite');
const path = require('path');

const dbPath = path.join(__dirname, '../../elisaos-code/packages/cli/.eliza/.elizadb');

(async () => {
  try {
    const db = new PGlite(dbPath);

    console.log('📊 PGLite Database - CustomerServiceBot');
    console.log('='.repeat(80));
    console.log('Database Location:', dbPath);
    console.log('');

    // Get memories
    const memCount = await db.query('SELECT COUNT(*) as count FROM memories');
    console.log('🧠 Total Memories:', memCount.rows[0].count);
    console.log('');

    if (parseInt(memCount.rows[0].count) > 0) {
      console.log('💭 All Memories (Most Recent First):');
      console.log('='.repeat(80));

      const memories = await db.query(`
        SELECT id, type, content, "roomId", "agentId", "createdAt"
        FROM memories
        ORDER BY "createdAt" DESC
      `);

      memories.rows.forEach((mem, idx) => {
        console.log(`\n[${idx + 1}/${memories.rows.length}] Memory ID: ${mem.id}`);
        console.log('─'.repeat(80));
        console.log('Type:', mem.type);
        console.log('Room ID:', mem.roomId);
        console.log('Agent ID:', mem.agentId);
        console.log('Created:', new Date(parseInt(mem.createdAt)).toLocaleString());
        console.log('');

        try {
          const content = JSON.parse(mem.content);
          if (content.text) {
            console.log('📝 Content Text:');
            console.log(content.text);
          } else {
            console.log('📝 Content (JSON):');
            console.log(JSON.stringify(content, null, 2));
          }
        } catch (e) {
          console.log('📝 Content (raw):', mem.content);
        }
      });
    }

    // Check for conversations
    try {
      const msgCount = await db.query('SELECT COUNT(*) as count FROM central_messages');
      console.log('\n\n💬 Central Messages:', msgCount.rows[0].count);

      if (parseInt(msgCount.rows[0].count) > 0) {
        console.log('');
        console.log('📨 All Conversations:');
        console.log('='.repeat(80));

        const messages = await db.query(`
          SELECT id, "roomId", "agentId", content, "createdAt"
          FROM central_messages
          ORDER BY "createdAt" DESC
        `);

        messages.rows.forEach((msg, idx) => {
          console.log(`\n[${idx + 1}/${messages.rows.length}] Message ID: ${msg.id}`);
          console.log('─'.repeat(80));
          console.log('Room ID:', msg.roomId);
          console.log('Agent ID:', msg.agentId);
          console.log('Created:', new Date(parseInt(msg.createdAt)).toLocaleString());

          try {
            const content = JSON.parse(msg.content);
            console.log('📝 Content:', content.text || JSON.stringify(content, null, 2));
          } catch (e) {
            console.log('📝 Content:', msg.content);
          }
        });
      }
    } catch (e) {
      console.log('⚠️  No central_messages table or error:', e.message);
    }

    await db.close();
    console.log('\n\n✅ Database query complete!');
    process.exit(0);
  } catch (error) {
    console.error('❌ Error:', error);
    process.exit(1);
  }
})();
