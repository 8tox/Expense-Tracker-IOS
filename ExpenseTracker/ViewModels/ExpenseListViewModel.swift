import Foundation

final class ExpenseListViewModel: ObservableObject {
    @Published private(set) var expenses: [Expense] = []

    private let store: ExpenseStoreProtocol

    init(store: ExpenseStoreProtocol = ExpenseStore()) {
        self.store = store
        self.expenses = store.loadExpenses().sorted(by: { $0.date > $1.date })
    }

    var totalThisMonth: Decimal {
        let calendar = Calendar.current
        let now = Date()

        return expenses
            .filter { calendar.isDate($0.date, equalTo: now, toGranularity: .month) }
            .reduce(0) { $0 + $1.amount }
    }

    func addExpense(
        title: String,
        amountString: String,
        category: Expense.Category,
        date: Date,
        note: String
    ) {
        let normalized = amountString.replacingOccurrences(of: ",", with: ".")
        guard let amount = Decimal(string: normalized), amount > 0 else {
            return
        }

        let expense = Expense(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            amount: amount,
            category: category,
            date: date,
            note: note.trimmingCharacters(in: .whitespacesAndNewlines)
        )

        guard !expense.title.isEmpty else {
            return
        }

        expenses.insert(expense, at: 0)
        persist()
    }

    func deleteExpenses(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
        persist()
    }

    private func persist() {
        store.saveExpenses(expenses)
    }
}
