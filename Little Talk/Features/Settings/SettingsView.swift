import SwiftUI

/// Placeholder for the Settings tab. Will hold the baby's profile and preferences.
struct SettingsView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Settings coming soon",
                systemImage: "gearshape",
                description: Text("You'll be able to update your baby's details here.")
            )
            .foregroundStyle(Theme.Colors.textSecondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Theme.Colors.background.ignoresSafeArea())
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
