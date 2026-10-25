#if DEBUG
import SwiftData
import SwiftUI

/// Preview-only: an in-memory store filled with a few days of sample History.
/// Use with `#Preview(traits: .sampleHistory)`.
struct SampleHistory: PreviewModifier {
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(
            for: MomentLog.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let calendar = Calendar.current
        let samples: [(momentID: String, daysAgo: Int, hoursAgo: Int)] = [
            ("take-a-turn", 0, 1),
            ("read-together", 0, 4),
            ("peekaboo", 1, 2),
            ("name-what-they-see", 3, 5)
        ]
        for sample in samples {
            let day = calendar.date(byAdding: .day, value: -sample.daysAgo, to: .now) ?? .now
            let time = calendar.date(byAdding: .hour, value: -sample.hoursAgo, to: day) ?? day
            container.mainContext.insert(MomentLog(momentID: sample.momentID, completedAt: time))
        }
        return container
    }

    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var sampleHistory: Self = .modifier(SampleHistory())
}
#endif
