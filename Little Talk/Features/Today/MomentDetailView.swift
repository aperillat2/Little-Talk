import SwiftData
import SwiftUI

/// A simple guided view shown after tapping "Try this moment".
///
/// Presents the steps; tapping Done saves the moment to History.
struct MomentDetailView: View {
    let moment: InteractionMoment

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.Spacing.large) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(moment.title)
                        .font(.largeTitle.bold())
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .accessibilityAddTraits(.isHeader)

                    Text(moment.instruction)
                        .font(.body)
                        .foregroundStyle(Theme.Colors.textSecondary)
                }

                VStack(alignment: .leading, spacing: Theme.Spacing.medium) {
                    ForEach(moment.steps.indices, id: \.self) { index in
                        StepRow(number: index + 1, text: moment.steps[index])
                    }
                }
                .padding(Theme.Spacing.large)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    Theme.Colors.surface,
                    in: .rect(cornerRadius: Theme.Radius.card, style: .continuous)
                )

                Button {
                    saveToHistory()
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.headline)
                        .foregroundStyle(Theme.Colors.onAccent)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .accessibilityHint("Saves this moment to History.")

                Text("Tapping Done saves this moment to your History.")
                    .font(.footnote)
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .frame(maxWidth: .infinity)
            }
            .padding(Theme.Spacing.large)
            .frame(maxWidth: 640, alignment: .leading)
            .frame(maxWidth: .infinity)
        }
        .background(Theme.Colors.background.ignoresSafeArea())
        .navigationTitle("Try this moment")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    private func saveToHistory() {
        modelContext.insert(MomentLog(momentID: moment.id))
        do {
            // Save right away rather than waiting for autosave, so the entry
            // survives even if the app is closed immediately afterwards.
            try modelContext.save()
        } catch {
            assertionFailure("Failed to save moment to History: \(error)")
        }
    }
}

/// One numbered step in a moment's guidance.
private struct StepRow: View {
    let number: Int
    let text: LocalizedStringResource

    @ScaledMetric(relativeTo: .subheadline) private var badgeSize: CGFloat = 28

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text(number, format: .number)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(Theme.Colors.onAccent)
                .frame(width: badgeSize, height: badgeSize)
                .background(Theme.Colors.accent, in: .circle)

            Text(text)
                .font(.body)
                .foregroundStyle(Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Step \(number): \(Text(text))"))
    }
}

#Preview {
    NavigationStack {
        MomentDetailView(moment: MomentLibrary.takeATurn)
    }
    .modelContainer(for: MomentLog.self, inMemory: true)
    .tint(Theme.Colors.accent)
}
