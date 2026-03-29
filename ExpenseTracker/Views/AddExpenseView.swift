import SwiftUI

struct AddExpenseView: View {
    @EnvironmentObject private var viewModel: ExpenseListViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var amount = ""
    @State private var category: Expense.Category = .food
    @State private var date = Date()
    @State private var note = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Expense") {
                    TextField("Title", text: $title)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    Picker("Category", selection: $category) {
                        ForEach(Expense.Category.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }

                Section("Note") {
                    TextField("Optional note", text: $note, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("New Expense")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.addExpense(
                            title: title,
                            amountString: amount,
                            category: category,
                            date: date,
                            note: note
                        )
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || amount.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddExpenseView()
        .environmentObject(ExpenseListViewModel())
}
