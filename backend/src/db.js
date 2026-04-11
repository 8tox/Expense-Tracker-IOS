const { Pool } = require('pg');

if (!process.env.DATABASE_URL) {
  throw new Error('DATABASE_URL is required');
}

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.PGSSLMODE === 'disable' ? false : { rejectUnauthorized: false }
});

async function ensureSchema() {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS expenses (
      id TEXT PRIMARY KEY,
      title TEXT NOT NULL,
      amount NUMERIC(12, 2) NOT NULL CHECK (amount > 0),
      category TEXT NOT NULL,
      expense_date DATE NOT NULL,
      note TEXT NOT NULL DEFAULT '',
      created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    );
  `);
}

module.exports = {
  pool,
  ensureSchema
};
