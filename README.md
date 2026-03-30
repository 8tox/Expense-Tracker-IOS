# Expense Tracker iOS (SwiftUI)

A lightweight iOS expense tracker built with SwiftUI.

## Features
- Add expenses with title, amount, category, date, and optional note.
- View a monthly total at the top of the app.
- Delete expenses with swipe-to-delete.
- Local persistence using `UserDefaults` + `Codable`.

## File structure
- `ExpenseTracker/ExpenseTrackerApp.swift`: app entry point.
- `ExpenseTracker/Models/Expense.swift`: expense model + categories.
- `ExpenseTracker/ViewModels/ExpenseListViewModel.swift`: state and business logic.
- `ExpenseTracker/Services/ExpenseStore.swift`: persistence.
- `ExpenseTracker/Views/*`: UI screens.

## Run
1. Create a new iOS App project in Xcode named `ExpenseTracker`.
2. Replace generated Swift files with these files.
3. Build and run on iOS Simulator
