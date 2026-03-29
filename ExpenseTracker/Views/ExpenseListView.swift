import SwiftUI

struct ExpenseListView: View {
    @EnvironmentObject private var viewModel: ExpenseListViewModel
    @State private var showingAddForm = false

    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        return formatter
    }()

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text("This Month")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(currencyFormatter.string(from: viewModel.totalThisMonth as NSDecimalNumber) ?? "$0.00")
                            .font(.headline)
                    }
                }

                Section("Expenses") {
                    if viewModel.expenses.isEmpty {
                        ContentUnavailableView(
                            "No expenses yet",
                            systemImage: "tray",
                            description: Text("Tap + to add your first expense.")
                        )
                    } else {
                        ForEach(viewModel.expenses) { expense in
                            ExpenseRowView(expense: expense, formatter: currencyFormatter)
                        }
                        .onDelete(perform: viewModel.deleteExpenses)
                    }
                }
            }
            .navigationTitle("Expense Tracker")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddForm = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add Expense")
                }
            }
            .sheet(isPresented: $showingAddForm) {
                AddExpenseView()
            }
        }
    }
}

#Preview {
    ExpenseListView()
        .environmentObject(ExpenseListViewModel())
}
