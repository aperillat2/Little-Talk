import Foundation

/// The History entries from one calendar day.
struct HistoryDay: Identifiable {
    /// The start of the day.
    let day: Date
    /// Newest first.
    let logs: [MomentLog]

    var id: Date { day }

    /// Groups logs by calendar day, newest day first and newest log first
    /// within each day.
    static func group(_ logs: [MomentLog], calendar: Calendar = .current) -> [HistoryDay] {
        Dictionary(grouping: logs) { calendar.startOfDay(for: $0.completedAt) }
            .map { day, logs in
                HistoryDay(day: day, logs: logs.sorted { $0.completedAt > $1.completedAt })
            }
            .sorted { $0.day > $1.day }
    }
}
