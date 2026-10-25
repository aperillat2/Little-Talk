import Foundation
import SwiftData
import Testing
@testable import Little_Talk

/// A fixed calendar so results don't depend on the machine's time zone.
private let calendar: Calendar = {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = .gmt
    return calendar
}()

private func date(_ year: Int, _ month: Int, _ day: Int, hour: Int) throws -> Date {
    try #require(calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour)))
}

// SwiftData models and the library use the app's main-actor isolation.
@MainActor
@Suite("History")
struct HistoryTests {
    @Test func groupsLogsByDayNewestFirst() throws {
        let logs = [
            MomentLog(momentID: "peekaboo", completedAt: try date(2025, 9, 14, hour: 9)),
            MomentLog(momentID: "take-a-turn", completedAt: try date(2025, 9, 15, hour: 8)),
            MomentLog(momentID: "read-together", completedAt: try date(2025, 9, 15, hour: 18))
        ]

        let days = HistoryDay.group(logs, calendar: calendar)

        #expect(days.count == 2)
        #expect(days.first?.day == calendar.startOfDay(for: try date(2025, 9, 15, hour: 0)))
        #expect(days.first?.logs.map(\.momentID) == ["read-together", "take-a-turn"])
        #expect(days.last?.logs.map(\.momentID) == ["peekaboo"])
    }

    @Test func groupingNoLogsGivesNoDays() {
        #expect(HistoryDay.group([], calendar: calendar).isEmpty)
    }

    @Test func logFindsItsMoment() {
        #expect(MomentLog(momentID: "take-a-turn").moment == MomentLibrary.takeATurn)
    }

    @Test func logForARemovedMomentHasNoMoment() {
        #expect(MomentLog(momentID: "no-longer-exists").moment == nil)
    }

    @Test func savedLogsCanBeFetchedNewestFirst() throws {
        let container = try ModelContainer(
            for: MomentLog.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext
        context.insert(MomentLog(momentID: "peekaboo", completedAt: try date(2025, 9, 14, hour: 9)))
        context.insert(MomentLog(momentID: "take-a-turn", completedAt: try date(2025, 9, 15, hour: 9)))
        try context.save()

        let descriptor = FetchDescriptor<MomentLog>(sortBy: [SortDescriptor(\.completedAt, order: .reverse)])
        let fetched = try context.fetch(descriptor)

        #expect(fetched.map(\.momentID) == ["take-a-turn", "peekaboo"])
    }
}
