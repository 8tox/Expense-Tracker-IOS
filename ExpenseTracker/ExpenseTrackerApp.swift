import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject private var viewModel = ExpenseListViewModel()

    var body: some Scene {
        WindowGroup {
            ExpenseListView()
                .environmentObject(viewModel)
        }
    }
}
