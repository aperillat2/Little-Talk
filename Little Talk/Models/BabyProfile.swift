import Foundation

/// Basic information about the baby, entered by the parent.
///
/// Age is never stored; it's calculated from `birthDate` so it stays correct
/// as the baby grows.
///
/// `nonisolated` because this is plain data: it opts out of the app's
/// default main-actor isolation so it can be used from any context.
nonisolated struct BabyProfile: Codable, Equatable, Sendable {
    /// Optional. Views fall back to "your baby" when this is blank.
    var name: String
    var birthDate: Date
    /// Set only when the baby was born early. Used to calculate adjusted age.
    var dueDate: Date?

    /// Clinicians stop adjusting for prematurity at around 24 months.
    static let adjustedAgeCutoffInMonths = 24

    /// The trimmed name, or `nil` if the parent left it blank.
    var displayName: String? {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    /// True only when a due date is set and falls after the birth date.
    var isBornEarly: Bool {
        guard let dueDate else { return false }
        return dueDate > birthDate
    }

    /// Age counted from the birth date.
    func age(on date: Date = .now, calendar: Calendar = .current) -> BabyAge {
        BabyAge(from: birthDate, to: date, calendar: calendar)
    }

    /// The age to use when choosing content.
    ///
    /// For babies born early this is the adjusted age (counted from the due
    /// date) until 24 months; otherwise it's the same as `age(on:)`.
    func developmentalAge(on date: Date = .now, calendar: Calendar = .current) -> BabyAge {
        let actualAge = age(on: date, calendar: calendar)
        guard isBornEarly, let dueDate,
              actualAge.months < Self.adjustedAgeCutoffInMonths else {
            return actualAge
        }
        return BabyAge(from: dueDate, to: date, calendar: calendar)
    }
}

/// A baby's age in completed months and days.
nonisolated struct BabyAge: Equatable, Sendable {
    /// Completed calendar months.
    let months: Int
    /// Total days elapsed. Useful for showing weeks in the first month.
    let days: Int

    var weeks: Int { days / 7 }

    init(months: Int, days: Int) {
        self.months = months
        self.days = days
    }

    /// Measures from the start of `start`'s day to the start of `end`'s day.
    /// Dates in the future (e.g. before a due date) count as zero.
    init(from start: Date, to end: Date, calendar: Calendar) {
        let startDay = calendar.startOfDay(for: start)
        let endDay = calendar.startOfDay(for: end)
        guard endDay > startDay else {
            self.init(months: 0, days: 0)
            return
        }
        let months = calendar.dateComponents([.month], from: startDay, to: endDay).month ?? 0
        let days = calendar.dateComponents([.day], from: startDay, to: endDay).day ?? 0
        self.init(months: months, days: days)
    }
}
