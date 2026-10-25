import Foundation
import Testing
import UIKit
@testable import Little_Talk

/// A fixed calendar so results don't depend on the machine's time zone.
private let calendar: Calendar = {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = .gmt
    return calendar
}()

private func date(_ year: Int, _ month: Int, _ day: Int) throws -> Date {
    try #require(calendar.date(from: DateComponents(year: year, month: month, day: day, hour: 12)))
}

// The library and moments use the app's default main-actor isolation.
@MainActor
@Suite("Moment library content")
struct MomentLibraryContentTests {
    @Test(arguments: MomentLibrary.coveredAgeRange)
    func everyMonthHasAtLeastTwoMoments(month: Int) {
        let suitable = MomentLibrary.all.filter { $0.ageRangeInMonths.contains(month) }
        #expect(suitable.count >= 2, "Only \(suitable.count) moment(s) for \(month) months")
    }

    @Test func idsAreUnique() {
        let ids = MomentLibrary.all.map(\.id)
        #expect(Set(ids).count == ids.count)
    }

    @Test func everyMomentHasSteps() {
        for moment in MomentLibrary.all {
            #expect(!moment.steps.isEmpty, "\(moment.id) has no steps")
        }
    }

    @Test func everySymbolExists() {
        for moment in MomentLibrary.all {
            #expect(UIImage(systemName: moment.symbolName) != nil, "\(moment.id) uses missing symbol \(moment.symbolName)")
        }
    }
}

@MainActor
@Suite("Moment selection")
struct MomentSelectionTests {
    @Test func onlyOffersMomentsForTheBabysAge() {
        let moments = MomentLibrary.moments(forAgeInMonths: 1)
        #expect(!moments.isEmpty)
        #expect(moments.allSatisfy { $0.ageRangeInMonths.contains(1) })
    }

    @Test func agesAbove24MonthsUseTheOldestContent() {
        #expect(MomentLibrary.moments(forAgeInMonths: 30) == MomentLibrary.moments(forAgeInMonths: 24))
    }

    @Test func featuredMomentSuitsTheBaby() throws {
        let profile = BabyProfile(name: "", birthDate: try date(2025, 1, 1))
        let today = try date(2025, 9, 15)
        let featured = MomentLibrary.featuredMoment(for: profile, on: today, calendar: calendar)
        #expect(featured.ageRangeInMonths.contains(8))
    }

    @Test func featuredMomentIsStableWithinADay() throws {
        let profile = BabyProfile(name: "", birthDate: try date(2025, 1, 1))
        let morning = try #require(calendar.date(from: DateComponents(year: 2025, month: 9, day: 15, hour: 7)))
        let evening = try #require(calendar.date(from: DateComponents(year: 2025, month: 9, day: 15, hour: 21)))

        #expect(
            MomentLibrary.featuredMoment(for: profile, on: morning, calendar: calendar)
                == MomentLibrary.featuredMoment(for: profile, on: evening, calendar: calendar)
        )
    }

    @Test func featuredMomentChangesFromDayToDay() throws {
        let profile = BabyProfile(name: "", birthDate: try date(2025, 1, 1))
        let first = MomentLibrary.featuredMoment(for: profile, on: try date(2025, 9, 15), calendar: calendar)
        let second = MomentLibrary.featuredMoment(for: profile, on: try date(2025, 9, 16), calendar: calendar)
        #expect(first != second)
    }

    @Test func babiesBornEarlyGetMomentsForTheirAdjustedAge() throws {
        // 13 months old, but born 3 months early: adjusted age is 10 months.
        let profile = BabyProfile(name: "", birthDate: try date(2024, 8, 1), dueDate: try date(2024, 11, 1))
        let today = try date(2025, 9, 1)

        let moments = MomentLibrary.moments(for: profile, on: today, calendar: calendar)
        #expect(moments == MomentLibrary.moments(forAgeInMonths: 10))
        #expect(!moments.contains(MomentLibrary.offerAChoice))
    }
}
