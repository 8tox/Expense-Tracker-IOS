import Foundation

protocol ExpenseStoreProtocol {
    func loadExpenses() -> [Expense]
    func saveExpenses(_ expenses: [Expense])
}

final class ExpenseStore: ExpenseStoreProtocol {
    private let key = "saved_expenses"
    private let defaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func loadExpenses() -> [Expense] {
        guard let data = defaults.data(forKey: key) else {
            return []
        }

        do {
            return try decoder.decode([Expense].self, from: data)
        } catch {
            return []
        }
    }

    func saveExpenses(_ expenses: [Expense]) {
        do {
            let data = try encoder.encode(expenses)
            defaults.set(data, forKey: key)
        } catch {
            // Ignore save failure for this lightweight sample app.
        }
    }
}
