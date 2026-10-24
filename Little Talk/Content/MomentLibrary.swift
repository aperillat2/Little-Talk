import Foundation

/// The local, bundled collection of interaction moments.
///
/// Content is kept here, separate from the UI, so it can grow into a full
/// age-based library without the views needing to change.
enum MomentLibrary {
    static let takeATurn = InteractionMoment(
        id: "take-a-turn",
        title: "Let them take a turn.",
        instruction: "When your baby makes a sound, try copying it, smiling, and pausing to give them a chance to respond in their own way.",
        whyItMatters: "Back-and-forth exchanges like this are some of your baby's first conversations. Each turn creates an opportunity for early communication.",
        steps: [
            "Wait for a sound, like a coo, babble, or squeal.",
            "Copy it back with a warm, smiling face.",
            "Pause for a few seconds and watch for their reply.",
            "Keep going for as long as they stay interested."
        ],
        ageRangeInMonths: 2...12,
        symbolName: "bubble.left.and.bubble.right"
    )

    static let nameWhatTheySee = InteractionMoment(
        id: "name-what-they-see",
        title: "Name what they notice.",
        instruction: "When your baby looks at or reaches for something, name it simply and warmly, like \"Ball! A round ball.\"",
        whyItMatters: "Naming what your baby is already focused on helps connect words to the world around them.",
        steps: [
            "Follow your baby's gaze or reach.",
            "Say the name of the object in a short, clear phrase.",
            "Repeat it once or twice while they explore."
        ],
        ageRangeInMonths: 6...18,
        symbolName: "eye"
    )

    static let pauseInASong = InteractionMoment(
        id: "pause-in-a-song",
        title: "Pause in a favorite song.",
        instruction: "Sing a song your baby knows, then pause just before a familiar word or action and wait to see how they join in.",
        whyItMatters: "Predictable songs and routines help babies anticipate what comes next and invite them to take part.",
        steps: [
            "Choose a short song you sing often.",
            "Pause before a familiar word or movement.",
            "Celebrate any sound, look, or wiggle as their turn."
        ],
        ageRangeInMonths: 6...24,
        symbolName: "music.note"
    )

    /// All available moments, in display order.
    static let all: [InteractionMoment] = [takeATurn, nameWhatTheySee, pauseInASong]

    /// The moment featured on the Today screen.
    /// A placeholder until age-based recommendations are implemented.
    static let featured = takeATurn
}
