# Expense Tracker iOS (SwiftUI) + Railway PostgreSQL Backend

A lightweight iOS expense tracker built with SwiftUI, now with a deployable backend API for Railway using PostgreSQL.

## What's in this repo
- **iOS client** (`ExpenseTracker/*`): SwiftUI app for adding and viewing expenses.
- **Backend API** (`backend/*`): Express + PostgreSQL service for storing expenses remotely.
- **Railway deployment config** (`railway.json`, `Procfile`): one-click deployment setup.

## iOS app features
- Add expenses with title, amount, category, date, and optional note.
- View a monthly total at the top of the app.
- Delete expenses with swipe-to-delete.
- Local persistence using `UserDefaults` + `Codable`.

## Backend API features
- `GET /health` for health checks.
- `GET /expenses` to list expenses.
- `POST /expenses` to create an expense.
- `DELETE /expenses/:id` to delete an expense.
- Auto-creates the `expenses` table on startup.

## Local backend run
1. Install dependencies:
   ```bash
   npm --prefix backend install
   ```
2. Copy environment file and update values:
   ```bash
   cp backend/.env.example backend/.env
   ```
3. Start backend:
   ```bash
   set -a && source backend/.env && set +a
   npm --prefix backend start
   ```

## Deploy to Railway (PostgreSQL)
1. Push this repository to GitHub.
2. In Railway, create a **New Project** from that GitHub repo.
3. Add a **PostgreSQL** service in Railway.
4. Add environment variable in app service:
   - `DATABASE_URL=${{Postgres.DATABASE_URL}}`
5. (Optional) Add:
   - `PORT` (Railway sets this automatically).
   - `PGSSLMODE=require` (default behavior in this backend is SSL enabled).
6. Deploy. Railway will use:
   - `railway.json` start command: `npm --prefix backend start`
   - `Procfile` fallback: `web: npm --prefix backend start`

## File structure
- `ExpenseTracker/ExpenseTrackerApp.swift`: app entry point.
- `ExpenseTracker/Models/Expense.swift`: expense model + categories.
- `ExpenseTracker/ViewModels/ExpenseListViewModel.swift`: state and business logic.
- `ExpenseTracker/Services/ExpenseStore.swift`: local persistence.
- `ExpenseTracker/Views/*`: UI screens.
- `backend/src/index.js`: API routes and bootstrapping.
- `backend/src/db.js`: PostgreSQL connection + schema bootstrap.
- `backend/sql/schema.sql`: explicit schema for manual setup.

## Notes
- The iOS app currently stores data locally in `UserDefaults`.
- To fully sync with Railway backend from iOS, add an API client layer that consumes `/expenses`.
