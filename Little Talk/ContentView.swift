import SwiftUI

/// The app's root view: the welcome screen until a baby profile exists,
/// then a tab bar with Today, History, and Settings.
struct ContentView: View {
    @Environment(BabyProfileStore.self) private var profileStore

    var body: some View {
        Group {
            if let profile = profileStore.profile {
                MainTabView(profile: profile)
            } else {
                WelcomeView()
            }
        }
        .tint(Theme.Colors.accent)
        .animation(.default, value: profileStore.profile == nil)
    }
}

private struct MainTabView: View {
    let profile: BabyProfile

    var body: some View {
        TabView {
            Tab("Today", systemImage: "sun.max") {
                TodayView(profile: profile)
            }
            Tab("History", systemImage: "clock") {
                HistoryView()
            }
            Tab("Settings", systemImage: "gearshape") {
                SettingsView()
            }
        }
    }
}

#Preview("With profile") {
    ContentView()
        .environment(BabyProfileStore(inMemoryProfile: .preview))
}

#Preview("First launch") {
    ContentView()
        .environment(BabyProfileStore(inMemoryProfile: nil))
}
