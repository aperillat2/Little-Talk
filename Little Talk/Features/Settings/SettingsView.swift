import SwiftUI

/// The Settings tab: edit the baby's details. Changes save immediately.
struct SettingsView: View {
    @Environment(BabyProfileStore.self) private var profileStore

    var body: some View {
        NavigationStack {
            Form {
                BabyProfileFields(profile: profileBinding)

                Section {
                } footer: {
                    Text("Your baby's details are saved only on this device.")
                }
            }
            .scrollContentBackground(.hidden)
            .background(Theme.Colors.background.ignoresSafeArea())
            .navigationTitle("Settings")
        }
    }

    /// Reads the stored profile and writes every edit straight back.
    /// Settings is only reachable once a profile exists, so the fallback
    /// value is never shown in practice.
    private var profileBinding: Binding<BabyProfile> {
        Binding {
            profileStore.profile ?? BabyProfile(name: "", birthDate: .now)
        } set: { newValue in
            profileStore.save(newValue)
        }
    }
}

#Preview {
    SettingsView()
        .environment(BabyProfileStore(inMemoryProfile: .preview))
        .tint(Theme.Colors.accent)
}
