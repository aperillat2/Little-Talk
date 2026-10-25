import Foundation

/// Chooses which moments suit a baby's age, and which one to feature today.
///
/// Deliberately simple: filter by developmental age, then rotate by day so
/// the featured moment changes daily but stays the same within a day.
extension MomentLibrary {
    /// The library covers 0 to 24 months; older ages use the 24-month content.
    static let coveredAgeRange = 0...24

    /// Moments suited to the given developmental age, in library order.
    static func moments(forAgeInMonths months: Int) -> [InteractionMoment] {
        let age = min(max(months, coveredAgeRange.lowerBound), coveredAgeRange.upperBound)
        let suitable = all.filter { $0.ageRangeInMonths.contains(age) }
        // Shouldn't happen while every month is covered; never show an empty list.
        return suitable.isEmpty ? all : suitable
    }

    /// Moments suited to this baby right now, using their adjusted age
    /// if they were born early.
    static func moments(
        for profile: BabyProfile,
        on date: Date = .now,
        calendar: Calendar = .current
    ) -> [InteractionMoment] {
        moments(forAgeInMonths: profile.developmentalAge(on: date, calendar: calendar).months)
    }

    /// Today's featured moment: one of the suitable moments, rotating daily.
    static func featuredMoment(
        for profile: BabyProfile,
        on date: Date = .now,
        calendar: Calendar = .current
    ) -> InteractionMoment {
        let suitable = moments(for: profile, on: date, calendar: calendar)
        // A day number that increases by one each calendar day.
        let dayNumber = calendar.ordinality(of: .day, in: .era, for: date) ?? 0
        return suitable[dayNumber % suitable.count]
    }
}
