import Foundation
import Testing
@testable import Little_Talk

/// A fixed calendar so results don't depend on the machine's time zone.
private let calendar: Calendar = {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = .gmt
    return calendar
}()

private func date(_ year: Int, _ month: Int, _ day: Int, hour: Int = 12) throws -> Date {
    try #require(calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour)))
}

@Suite("Baby age")
struct BabyAgeTests {
    @Test func countsWholeMonthsOnTheSameDayOfMonth() throws {
        let age = BabyAge(from: try date(2025, 3, 15), to: try date(2025, 4, 15), calendar: calendar)
        #expect(age.months == 1)
    }

    @Test func doesNotRoundUpTheDayBeforeAMonthMark() throws {
        let age = BabyAge(from: try date(2025, 3, 15), to: try date(2025, 4, 14), calendar: calendar)
        #expect(age.months == 0)
        #expect(age.days == 30)
    }

    @Test func monthEndBirthdayTurnsOneMonthOnTheLastDayOfAShorterMonth() throws {
        let age = BabyAge(from: try date(2025, 1, 31), to: try date(2025, 2, 28), calendar: calendar)
        #expect(age.months == 1)
    }

    @Test func leapDayBabyTurnsTwelveMonthsOnFebruary28() throws {
        let age = BabyAge(from: try date(2024, 2, 29), to: try date(2025, 2, 28), calendar: calendar)
        #expect(age.months == 12)
    }

    @Test func reportsWeeksDuringTheFirstMonth() throws {
        let age = BabyAge(from: try date(2025, 6, 1), to: try date(2025, 6, 21), calendar: calendar)
        #expect(age.months == 0)
        #expect(age.weeks == 2)
    }

    @Test func ignoresTimeOfDay() throws {
        // Born late in the evening, checked early the next morning: one day old.
        let age = BabyAge(
            from: try date(2025, 6, 1, hour: 23),
            to: try date(2025, 6, 2, hour: 1),
            calendar: calendar
        )
        #expect(age.days == 1)
    }

    @Test func futureDatesCountAsZero() throws {
        let age = BabyAge(from: try date(2025, 6, 10), to: try date(2025, 6, 1), calendar: calendar)
        #expect(age == BabyAge(months: 0, days: 0))
    }
}

@Suite("Adjusted age")
struct AdjustedAgeTests {
    @Test func usesTheDueDateForBabiesBornEarly() throws {
        let profile = BabyProfile(name: "", birthDate: try date(2025, 1, 1), dueDate: try date(2025, 3, 1))
        let today = try date(2025, 7, 1)

        #expect(profile.isBornEarly)
        #expect(profile.age(on: today, calendar: calendar).months == 6)
        #expect(profile.developmentalAge(on: today, calendar: calendar).months == 4)
    }

    @Test func stopsAdjustingAtTwentyFourMonths() throws {
        let profile = BabyProfile(name: "", birthDate: try date(2024, 1, 1), dueDate: try date(2024, 3, 1))
        let today = try date(2026, 1, 1)

        #expect(profile.developmentalAge(on: today, calendar: calendar).months == 24)
    }

    @Test func isZeroBeforeTheDueDate() throws {
        let profile = BabyProfile(name: "", birthDate: try date(2025, 1, 1), dueDate: try date(2025, 3, 1))
        let beforeDueDate = try date(2025, 2, 1)

        #expect(profile.developmentalAge(on: beforeDueDate, calendar: calendar) == BabyAge(months: 0, days: 0))
    }

    @Test func ignoresADueDateOnOrBeforeTheBirthDate() throws {
        let profile = BabyProfile(name: "", birthDate: try date(2025, 3, 1), dueDate: try date(2025, 2, 1))
        let today = try date(2025, 9, 1)

        #expect(!profile.isBornEarly)
        #expect(profile.developmentalAge(on: today, calendar: calendar).months == 6)
    }

    @Test func usesActualAgeWhenNoDueDateIsSet() throws {
        let profile = BabyProfile(name: "", birthDate: try date(2025, 1, 1))
        let today = try date(2025, 7, 1)

        #expect(profile.developmentalAge(on: today, calendar: calendar) == profile.age(on: today, calendar: calendar))
    }
}

@Suite("Profile details")
struct BabyProfileDetailsTests {
    @Test(arguments: ["", "   ", "\n"])
    func blankNamesHaveNoDisplayName(name: String) throws {
        let profile = BabyProfile(name: name, birthDate: try date(2025, 1, 1))
        #expect(profile.displayName == nil)
    }

    @Test func displayNameIsTrimmed() throws {
        let profile = BabyProfile(name: "  Maya ", birthDate: try date(2025, 1, 1))
        #expect(profile.displayName == "Maya")
    }
}

// The store is UI state and lives on the main actor, like the app's views.
@MainActor
@Suite("Profile storage")
struct BabyProfileStoreTests {
    @Test func savedProfileIsLoadedByANewStore() throws {
        let suiteName = "BabyProfileStoreTests-\(UUID().uuidString)"
        let defaults = try #require(UserDefaults(suiteName: suiteName))
        defer { defaults.removePersistentDomain(forName: suiteName) }

        let profile = BabyProfile(name: "Maya", birthDate: try date(2025, 1, 1), dueDate: try date(2025, 2, 1))
        BabyProfileStore(defaults: defaults).save(profile)

        #expect(BabyProfileStore(defaults: defaults).profile == profile)
    }

    @Test func startsEmptyWhenNothingIsSaved() throws {
        let suiteName = "BabyProfileStoreTests-\(UUID().uuidString)"
        let defaults = try #require(UserDefaults(suiteName: suiteName))
        defer { defaults.removePersistentDomain(forName: suiteName) }

        #expect(BabyProfileStore(defaults: defaults).profile == nil)
    }
}
