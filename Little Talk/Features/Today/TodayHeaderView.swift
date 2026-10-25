import SwiftUI

/// App name, greeting, and the baby's age at the top of the Today screen.
struct TodayHeaderView: View {
    let profile: BabyProfile

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.small) {
            Text("LittleTalk")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Theme.Colors.accent)

            Text("Good to see you")
                .font(.largeTitle.bold())
                .foregroundStyle(Theme.Colors.textPrimary)
                .accessibilityAddTraits(.isHeader)

            subtitle
                .font(.body)
                .foregroundStyle(Theme.Colors.textSecondary)

            BabyAgeBadge(
                age: profile.age(),
                adjustedAge: profile.isBornEarly ? profile.developmentalAge() : nil
            )
            .padding(.top, Theme.Spacing.small)
        }
    }

    // Two full sentences rather than one with "your baby" swapped in, so
    // translators can phrase each naturally.
    private var subtitle: Text {
        if let name = profile.displayName {
            Text("Here's one small moment to share with \(name) today.")
        } else {
            Text("Here's one small moment to share with your baby today.")
        }
    }
}

/// A soft sage pill showing the baby's age, e.g. "8 months old", plus the
/// adjusted age for babies born early.
struct BabyAgeBadge: View {
    let age: BabyAge
    /// Shown as a second line when the baby was born early.
    var adjustedAge: BabyAge? = nil

    var body: some View {
        Label {
            VStack(alignment: .leading, spacing: 2) {
                Self.ageText(age)
                if let adjustedAge {
                    Self.adjustedAgeText(adjustedAge)
                        .font(.footnote)
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
            }
        } icon: {
            Image(systemName: "birthday.cake")
                .foregroundStyle(Theme.Colors.accent)
        }
        .font(.subheadline.weight(.medium))
        .foregroundStyle(Theme.Colors.textPrimary)
        .padding(.horizontal, 14)
        .padding(.vertical, Theme.Spacing.small)
        .background(Theme.Colors.accentSoft, in: .rect(cornerRadius: 18, style: .continuous))
        .accessibilityElement(children: .combine)
    }

    // `inflect: true` picks singular or plural ("1 month", "2 months") automatically.
    private static func ageText(_ age: BabyAge) -> Text {
        if age.months >= 1 {
            Text("^[\(age.months) month](inflect: true) old")
        } else if age.weeks >= 1 {
            Text("^[\(age.weeks) week](inflect: true) old")
        } else {
            Text("Less than a week old")
        }
    }

    private static func adjustedAgeText(_ age: BabyAge) -> Text {
        if age.months >= 1 {
            Text("^[\(age.months) month](inflect: true) adjusted")
        } else if age.weeks >= 1 {
            Text("^[\(age.weeks) week](inflect: true) adjusted")
        } else {
            Text("Less than a week adjusted")
        }
    }
}

#Preview("Named") {
    TodayHeaderView(profile: .preview)
        .padding()
        .background(Theme.Colors.background)
}

#Preview("Born early, no name") {
    let birthDate = Calendar.current.date(byAdding: .month, value: -5, to: .now) ?? .now
    let dueDate = Calendar.current.date(byAdding: .weekOfYear, value: 8, to: birthDate)
    TodayHeaderView(profile: BabyProfile(name: "", birthDate: birthDate, dueDate: dueDate))
        .padding()
        .background(Theme.Colors.background)
}
