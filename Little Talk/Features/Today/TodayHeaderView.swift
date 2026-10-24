import SwiftUI

/// App name, greeting, and the baby's age at the top of the Today screen.
struct TodayHeaderView: View {
    let baby: BabyProfile

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.small) {
            Text("LittleTalk")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Theme.Colors.accent)

            Text("Good to see you")
                .font(.largeTitle.bold())
                .foregroundStyle(Theme.Colors.textPrimary)
                .accessibilityAddTraits(.isHeader)

            Text("Here's one small moment to share with your baby today.")
                .font(.body)
                .foregroundStyle(Theme.Colors.textSecondary)

            BabyAgeBadge(ageInMonths: baby.ageInMonths)
                .padding(.top, Theme.Spacing.small)
        }
    }
}

/// A soft sage pill showing the baby's age, e.g. "8 months old".
struct BabyAgeBadge: View {
    let ageInMonths: Int

    var body: some View {
        Label {
            // `inflect: true` picks "month" or "months" automatically.
            Text("^[\(ageInMonths) month](inflect: true) old")
        } icon: {
            Image(systemName: "birthday.cake")
                .foregroundStyle(Theme.Colors.accent)
        }
        .font(.subheadline.weight(.medium))
        .foregroundStyle(Theme.Colors.textPrimary)
        .padding(.horizontal, 14)
        .padding(.vertical, Theme.Spacing.small)
        .background(Theme.Colors.accentSoft, in: .capsule)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Baby's age: ^[\(ageInMonths) month](inflect: true)"))
    }
}

#Preview {
    TodayHeaderView(baby: .placeholder)
        .padding()
        .background(Theme.Colors.background)
}
