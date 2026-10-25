import SwiftUI

@main struct LittleTalkApp: App {
    @State private var profileStore = BabyProfileStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(profileStore)
        }
    }
}
