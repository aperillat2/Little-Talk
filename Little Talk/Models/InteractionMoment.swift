import Foundation

/// A single coaching card: one small, everyday interaction a parent can try.
///
/// This is plain data with no UI concerns, so future content (age-specific
/// cards, bundled JSON, etc.) can be added without touching any views.
/// Text fields are `LocalizedStringResource` so they are extracted into the
/// String Catalog and can be translated.
struct InteractionMoment: Identifiable, Hashable, Sendable {
    /// Stable identifier. Keep this unchanged once shipped; it will be used
    /// to reference moments in history later.
    let id: String
    let title: LocalizedStringResource
    let instruction: LocalizedStringResource
    /// Short, parent-friendly explanation of why the moment matters.
    let whyItMatters: LocalizedStringResource
    /// Suggested steps shown on the "Try this moment" screen.
    let steps: [LocalizedStringResource]
    /// Ages (in months) this moment is best suited for.
    let ageRangeInMonths: ClosedRange<Int>
    /// SF Symbol name used as the card's illustration.
    let symbolName: String

    // Identity is defined by `id` alone. This also keeps the type Hashable,
    // since `LocalizedStringResource` is only Equatable.
    static func == (lhs: InteractionMoment, rhs: InteractionMoment) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
