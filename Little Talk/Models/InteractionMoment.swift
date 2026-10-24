import Foundation

/// A single coaching card: one small, everyday interaction a parent can try.
///
/// This is plain data with no UI concerns, so future content (age-specific
/// cards, bundled JSON, etc.) can be added without touching any views.
struct InteractionMoment: Identifiable, Hashable {
    /// Stable identifier. Keep this unchanged once shipped; it will be used
    /// to reference moments in history later.
    let id: String
    let title: String
    let instruction: String
    /// Short, parent-friendly explanation of why the moment matters.
    let whyItMatters: String
    /// Suggested steps shown on the "Try this moment" screen.
    let steps: [String]
    /// Ages (in months) this moment is best suited for.
    let ageRangeInMonths: ClosedRange<Int>
    /// SF Symbol name used as the card's illustration.
    let symbolName: String
}
