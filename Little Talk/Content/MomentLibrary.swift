import Foundation

/// The local, bundled collection of interaction moments.
///
/// Content is kept here, separate from the UI, so it can grow into a full
/// age-based library without the views needing to change.
///
/// Age ranges are inclusive and use the baby's developmental (adjusted) age
/// in months. Every month from 0 to 24 should be covered by at least two
/// moments; a unit test enforces this.
///
/// Note: this is starter content based on widely shared early-language
/// guidance. Have it reviewed by a speech-language pathologist before release.
enum MomentLibrary {

    // MARK: - From birth

    static let faceToFace = InteractionMoment(
        id: "face-to-face",
        title: "Share a face-to-face chat.",
        instruction: "Hold your baby close, about the length of your forearm from your face, and talk softly while you smile. Then pause and watch how they respond.",
        whyItMatters: "Young babies love studying faces and voices. These quiet chats are where conversation begins.",
        steps: [
            "Find a calm moment when your baby is alert.",
            "Bring your face close and speak in a gentle, sing-song voice.",
            "Pause and watch for a look, a wiggle, or a coo.",
            "Respond warmly to whatever they do."
        ],
        ageRangeInMonths: 0...3,
        symbolName: "face.smiling"
    )

    static let narrateTheRoutine = InteractionMoment(
        id: "narrate-the-routine",
        title: "Talk through the routine.",
        instruction: "During a diaper change, bath, or feed, describe what you're doing in a warm voice: \"Now the warm cloth. Here's your foot!\"",
        whyItMatters: "Hearing everyday words spoken directly to them helps babies build the understanding that comes before talking.",
        steps: [
            "Choose a routine you do every day.",
            "Describe each step in short, simple phrases.",
            "Look at your baby as you talk, and pause now and then.",
            "Use the same words each time so they become familiar."
        ],
        ageRangeInMonths: 0...12,
        symbolName: "drop"
    )

    static let gentleSong = InteractionMoment(
        id: "gentle-song",
        title: "Sing a slow, gentle song.",
        instruction: "Sing a simple song or lullaby slowly while you hold your baby's gaze. It doesn't need to be perfect; your voice is what matters.",
        whyItMatters: "The rhythm and melody of songs help babies tune in to the sounds of language.",
        steps: [
            "Pick a short song you know well.",
            "Sing it slowly, looking at your baby.",
            "Repeat it often so it becomes familiar and comforting."
        ],
        ageRangeInMonths: 0...6,
        symbolName: "heart"
    )

    // MARK: - From a few months

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

    // MARK: - From six months

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

    static let peekaboo = InteractionMoment(
        id: "peekaboo",
        title: "Play peekaboo.",
        instruction: "Hide your face behind your hands or a cloth, wait a moment, then reappear with a cheerful \"Peekaboo!\" Pause to let them react before you go again.",
        whyItMatters: "Simple repeated games teach the rhythm of conversation: your turn, then my turn.",
        steps: [
            "Hide your face and ask, \"Where did I go?\"",
            "Wait a beat to build a little anticipation.",
            "Reappear with a big smile and \"Peekaboo!\"",
            "Pause and see if they ask for more with a look, sound, or reach."
        ],
        ageRangeInMonths: 6...12,
        symbolName: "eyes"
    )

    static let readTogether = InteractionMoment(
        id: "read-together",
        title: "Point and name in a book.",
        instruction: "Share a sturdy picture book. Point to a picture, name it, and let your baby touch the page or help turn it.",
        whyItMatters: "Looking at books together exposes babies to new words and makes words feel like a shared, joyful activity.",
        steps: [
            "Sit close with a board book.",
            "Point to one picture at a time and name it.",
            "Let them pat, explore, or turn pages; there's no need to finish the book.",
            "Follow their interest and return to favorite pages."
        ],
        ageRangeInMonths: 6...18,
        symbolName: "book"
    )

    // MARK: - From eight months

    static let wordsWithGestures = InteractionMoment(
        id: "words-with-gestures",
        title: "Pair words with gestures.",
        instruction: "Wave while you say \"bye-bye,\" or hold out your hands while you ask \"up?\" Use the same gesture and word together each time.",
        whyItMatters: "Gestures often come before words. Pairing them helps babies understand and gives them a way to communicate early.",
        steps: [
            "Choose one or two everyday gestures, like waving or reaching up.",
            "Say the word every time you make the gesture.",
            "Pause and watch whether they try it too.",
            "Celebrate any attempt, even a partial wave."
        ],
        ageRangeInMonths: 8...14,
        symbolName: "hand.wave"
    )

    // MARK: - From twelve months

    static let offerAChoice = InteractionMoment(
        id: "offer-a-choice",
        title: "Offer a simple choice.",
        instruction: "Hold up two options and name them: \"Banana or apple?\" Wait to see how your toddler tells you, whether that's a reach, a point, a sound, or a word.",
        whyItMatters: "Choices give toddlers a real reason to communicate, and every way they respond counts.",
        steps: [
            "Hold up two things they like, one in each hand.",
            "Name each one clearly as you show it.",
            "Wait patiently for them to choose.",
            "Name their choice as you hand it over: \"Apple!\""
        ],
        ageRangeInMonths: 12...24,
        symbolName: "square.split.2x1"
    )

    static let addOneWord = InteractionMoment(
        id: "add-one-word",
        title: "Add one more word.",
        instruction: "When your toddler says or tries a word, repeat it back and add one more: \"Ball!\" becomes \"Big ball!\"",
        whyItMatters: "Building on their words shows them the next small step, without any pressure to repeat it.",
        steps: [
            "Listen for a word or word attempt.",
            "Repeat it clearly so they hear it said fully.",
            "Add just one word, like a color, size, or action.",
            "Don't ask them to copy you; just keep the conversation going."
        ],
        ageRangeInMonths: 12...24,
        symbolName: "plus.bubble"
    )

    static let waitBeforeHelping = InteractionMoment(
        id: "wait-before-helping",
        title: "Wait a moment before helping.",
        instruction: "When your toddler wants something, pause for a few seconds with an expectant look before you help, giving them a chance to tell you in their own way.",
        whyItMatters: "A short, friendly pause creates space for them to communicate instead of having every need met before they try.",
        steps: [
            "Notice when they want something, like a snack or a toy.",
            "Look at them expectantly and count to five in your head.",
            "Respond to any sound, gesture, or word they use.",
            "Help right away if they become frustrated."
        ],
        ageRangeInMonths: 12...24,
        symbolName: "hourglass"
    )

    // MARK: - From eighteen months

    static let pretendPlay = InteractionMoment(
        id: "pretend-play",
        title: "Play pretend together.",
        instruction: "Feed a teddy, stir a pretend soup, or put a doll to bed. Talk about what you're both doing as you play.",
        whyItMatters: "Pretend play gives toddlers lots to talk about and helps them link words to actions and ideas.",
        steps: [
            "Set out a few familiar objects, like a cup, spoon, and soft toy.",
            "Start a simple pretend action and describe it.",
            "Follow their lead and copy what they do.",
            "Add words for each action: \"Teddy's drinking!\""
        ],
        ageRangeInMonths: 18...24,
        symbolName: "teddybear"
    )

    static let nameTheFeeling = InteractionMoment(
        id: "name-the-feeling",
        title: "Name the feeling.",
        instruction: "When your toddler is happy, frustrated, or tired, put a simple word to it: \"You're frustrated. The block fell down.\"",
        whyItMatters: "Feeling words help toddlers understand themselves and, over time, tell you how they feel.",
        steps: [
            "Notice a clear feeling, big or small.",
            "Name it in a calm, simple sentence.",
            "Connect it to what happened.",
            "Offer comfort or help if they need it."
        ],
        ageRangeInMonths: 18...24,
        symbolName: "heart.text.square"
    )

    /// All available moments, roughly in age order.
    static let all: [InteractionMoment] = [
        faceToFace, narrateTheRoutine, gentleSong,
        takeATurn,
        nameWhatTheySee, pauseInASong, peekaboo, readTogether,
        wordsWithGestures,
        offerAChoice, addOneWord, waitBeforeHelping,
        pretendPlay, nameTheFeeling
    ]
}
