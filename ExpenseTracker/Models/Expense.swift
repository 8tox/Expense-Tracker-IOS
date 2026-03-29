import Foundation

struct Expense: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var amount: Decimal
    var category: Category
    var date: Date
    var note: String

    enum Category: String, Codable, CaseIterable, Identifiable {
        case food = "Food"
        case transport = "Transport"
        case shopping = "Shopping"
        case bills = "Bills"
        case health = "Health"
        case entertainment = "Entertainment"
        case other = "Other"

        var id: String { rawValue }
    }

    init(
        id: UUID = UUID(),
        title: String,
        amount: Decimal,
        category: Category,
        date: Date = Date(),
        note: String = ""
    ) {
        self.id = id
        self.title = title
        self.amount = amount
        self.category = category
        self.date = date
        self.note = note
    }
}
