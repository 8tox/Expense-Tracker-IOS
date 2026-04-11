CREATE TABLE IF NOT EXISTS expenses (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  amount NUMERIC(12, 2) NOT NULL CHECK (amount > 0),
  category TEXT NOT NULL,
  expense_date DATE NOT NULL,
  note TEXT NOT NULL DEFAULT '',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
