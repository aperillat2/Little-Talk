import SwiftData
import SwiftUI

/// The History tab: moments the parent has tried, grouped by day.
struct HistoryView: View {
    @Query(sort: \MomentLog.completedAt, order: .reverse) private var logs: [MomentLog]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            Group {
                if logs.isEmpty {
                    ContentUnavailableView(
                        "No moments yet",
                        systemImage: "clock",
                        description: Text("When you finish a moment and tap Done, it will appear here.")
                    )
                    .foregroundStyle(Theme.Colors.textSecondary)
                } else {
                    historyList
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Theme.Colors.background.ignoresSafeArea())
            .navigationTitle("History")
        }
    }

    private var historyList: some View {
        List {
            ForEach(HistoryDay.group(logs)) { day in
                Section {
                    ForEach(day.logs) { log in
                        HistoryRow(log: log)
                            .listRowBackground(Theme.Colors.surface)
                    }
                    .onDelete { offsets in
                        delete(offsets.map { day.logs[$0] })
                    }
                } header: {
                    DayHeader(day: day.day)
                }
            }
        }
        .scrollContentBackground(.hidden)
    }

    private func delete(_ logsToDelete: [MomentLog]) {
        for log in logsToDelete {
            modelContext.delete(log)
        }
    }
}

/// "Today", "Yesterday", or the date, e.g. "Monday, October 20".
private struct DayHeader: View {
    let day: Date

    var body: some View {
        if Calendar.current.isDateInToday(day) {
            Text("Today")
        } else if Calendar.current.isDateInYesterday(day) {
            Text("Yesterday")
        } else {
            Text(day, format: .dateTime.weekday(.wide).month(.wide).day())
        }
    }
}

/// One tried moment: its icon, title, and the time it was saved.
private struct HistoryRow: View {
    let log: MomentLog

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: log.moment?.symbolName ?? "sparkles")
                .foregroundStyle(Theme.Colors.accent)
                .frame(width: 28)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 2) {
                if let moment = log.moment {
                    Text(moment.title)
                } else {
                    // The moment was removed from the library in an update.
                    Text("A moment you tried")
                }
            }
            .font(.headline)
            .foregroundStyle(Theme.Colors.textPrimary)

            Spacer(minLength: 0)

            Text(log.completedAt, format: .dateTime.hour().minute())
                .font(.subheadline)
                .foregroundStyle(Theme.Colors.textSecondary)
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
    }
}

#Preview("With history", traits: .sampleHistory) {
    HistoryView()
        .tint(Theme.Colors.accent)
}

#Preview("Empty") {
    HistoryView()
        .modelContainer(for: MomentLog.self, inMemory: true)
}
