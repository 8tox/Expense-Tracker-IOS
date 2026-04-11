const crypto = require('crypto');
const express = require('express');
const cors = require('cors');
const { pool, ensureSchema } = require('./db');

const app = express();
const port = Number(process.env.PORT || 3000);

app.use(cors());
app.use(express.json());

function mapExpense(row) {
  return {
    id: row.id,
    title: row.title,
    amount: row.amount,
    category: row.category,
    date: row.expense_date,
    note: row.note,
    createdAt: row.created_at
  };
}

app.get('/health', async (_req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({ ok: true });
  } catch (error) {
    res.status(500).json({ ok: false, error: 'Database unavailable' });
  }
});

app.get('/expenses', async (_req, res) => {
  const result = await pool.query(
    `SELECT id, title, amount::text, category, expense_date, note, created_at
     FROM expenses
     ORDER BY expense_date DESC, created_at DESC`
  );

  res.json(result.rows.map(mapExpense));
});

app.post('/expenses', async (req, res) => {
  const { title, amount, category, date, note = '' } = req.body;

  if (!title || !category || !date || Number(amount) <= 0) {
    return res.status(400).json({ error: 'title, amount, category, and date are required' });
  }

  const id = crypto.randomUUID();
  const result = await pool.query(
    `INSERT INTO expenses (id, title, amount, category, expense_date, note)
     VALUES ($1, $2, $3, $4, $5, $6)
     RETURNING id, title, amount::text, category, expense_date, note, created_at`,
    [id, String(title).trim(), amount, category, date, String(note).trim()]
  );

  return res.status(201).json(mapExpense(result.rows[0]));
});

app.delete('/expenses/:id', async (req, res) => {
  const result = await pool.query('DELETE FROM expenses WHERE id = $1', [req.params.id]);

  if (result.rowCount === 0) {
    return res.status(404).json({ error: 'Expense not found' });
  }

  return res.status(204).send();
});

(async () => {
  try {
    await ensureSchema();
    app.listen(port, () => {
      // eslint-disable-next-line no-console
      console.log(`Expense backend listening on port ${port}`);
    });
  } catch (error) {
    // eslint-disable-next-line no-console
    console.error('Failed to start API', error);
    process.exit(1);
  }
})();
