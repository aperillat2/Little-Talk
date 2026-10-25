import SwiftUI

/// First-launch screen that collects the baby's details.
///
/// Shown by `ContentView` until a profile has been saved.
struct WelcomeView: View {
    @Environment(BabyProfileStore.self) private var profileStore
    @State private var draft = BabyProfile(name: "", birthDate: .now)

    var body: some View {
        NavigationStack {
            Form {
                intro
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())

                BabyProfileFields(profile: $draft)
            }
            .scrollContentBackground(.hidden)
            .background(Theme.Colors.background.ignoresSafeArea())
            .safeAreaInset(edge: .bottom) {
                continueButton
            }
        }
    }

    private var intro: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.small) {
            Text("LittleTalk")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Theme.Colors.accent)

            Text("Welcome")
                .font(.largeTitle.bold())
                .foregroundStyle(Theme.Colors.textPrimary)
                .accessibilityAddTraits(.isHeader)

            Text("Tell us a little about your baby so we can suggest moments that fit their age.")
                .font(.body)
                .foregroundStyle(Theme.Colors.textSecondary)
        }
        .padding(.vertical, Theme.Spacing.medium)
    }

    private var continueButton: some View {
        VStack(spacing: Theme.Spacing.small) {
            Button {
                profileStore.save(draft)
            } label: {
                Text("Continue")
                    .font(.headline)
                    .foregroundStyle(Theme.Colors.onAccent)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)

            Text("Saved only on this device.")
                .font(.footnote)
                .foregroundStyle(Theme.Colors.textSecondary)
        }
        .padding(.horizontal, Theme.Spacing.large)
        .padding(.vertical, Theme.Spacing.medium)
        .background(Theme.Colors.background)
    }
}

#Preview {
    WelcomeView()
        .environment(BabyProfileStore(inMemoryProfile: nil))
        .tint(Theme.Colors.accent)
}
