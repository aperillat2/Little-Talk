import SwiftUI

/// Placeholder for the History tab. Will list moments the parent has tried.
struct HistoryView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "No moments yet",
                systemImage: "clock",
                description: Text("Moments you try will appear here.")
            )
            .foregroundStyle(Theme.Colors.textSecondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Theme.Colors.background.ignoresSafeArea())
            .navigationTitle("History")
        }
    }
}

#Preview {
    HistoryView()
}
