import SwiftUI

/// The app's root view: a tab bar with Today, History, and Settings.
struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Today", systemImage: "sun.max") {
                TodayView()
            }
            Tab("History", systemImage: "clock") {
                HistoryView()
            }
            Tab("Settings", systemImage: "gearshape") {
                SettingsView()
            }
        }
        .tint(Theme.Colors.accent)
    }
}

#Preview {
    ContentView()
}
