import SwiftUI

/// The featured interaction card on the Today screen.
///
/// "Try this moment" pushes the moment's detail screen through the enclosing
/// `NavigationStack`; "Choose another moment" is reported to the parent view.
struct FeaturedMomentCard: View {
    let moment: InteractionMoment
    /// Shows a "Tried today" confirmation once the moment is saved to History.
    var wasTriedToday: Bool = false
    let onChooseAnother: () -> Void

    @ScaledMetric(relativeTo: .title2) private var iconSize: CGFloat = 48

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.large) {
            HStack(spacing: 12) {
                Image(systemName: moment.symbolName)
                    .font(.title3)
                    .foregroundStyle(Theme.Colors.accent)
                    .frame(width: iconSize, height: iconSize)
                    .background(Theme.Colors.accentSoft, in: .circle)
                    .accessibilityHidden(true)

                if wasTriedToday {
                    Label("Tried today", systemImage: "checkmark.circle.fill")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Theme.Colors.accent)
                } else {
                    Text("Today's moment")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                Text(moment.title)
                    .font(.title2.bold())
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .accessibilityAddTraits(.isHeader)

                Text(moment.instruction)
                    .font(.body)
                    .foregroundStyle(Theme.Colors.textPrimary)
            }

            Text(moment.whyItMatters)
                .font(.callout)
                .foregroundStyle(Theme.Colors.textSecondary)

            actions
        }
        .padding(Theme.Spacing.large)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Theme.Colors.surface,
            in: .rect(cornerRadius: Theme.Radius.card, style: .continuous)
        )
        .shadow(color: .black.opacity(0.06), radius: 20, y: 8)
    }

    private var actions: some View {
        VStack(spacing: Theme.Spacing.small) {
            NavigationLink(value: moment) {
                Text("Try this moment")
                    .font(.headline)
                    .foregroundStyle(Theme.Colors.onAccent)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .accessibilityHint("Opens step-by-step guidance for this moment.")

            Button("Choose another moment", action: onChooseAnother)
                .font(.body.weight(.semibold))
                .buttonStyle(.borderless)
                .controlSize(.large)
                .frame(maxWidth: .infinity)
                .accessibilityHint("Shows other moments you can try.")
        }
        .padding(.top, Theme.Spacing.small)
    }
}

#Preview("Not tried") {
    NavigationStack {
        FeaturedMomentCard(moment: MomentLibrary.takeATurn) {}
            .padding()
            .frame(maxHeight: .infinity)
            .background(Theme.Colors.background)
    }
    .tint(Theme.Colors.accent)
}

#Preview("Tried today") {
    NavigationStack {
        FeaturedMomentCard(moment: MomentLibrary.takeATurn, wasTriedToday: true) {}
            .padding()
            .frame(maxHeight: .infinity)
            .background(Theme.Colors.background)
    }
    .tint(Theme.Colors.accent)
}
