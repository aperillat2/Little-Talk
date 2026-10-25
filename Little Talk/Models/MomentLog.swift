import Foundation
import SwiftData

/// A record that the parent tried a moment, saved when they tap Done.
///
/// Stores only the moment's stable `id`, not its text, so History always
/// shows the current (and translated) wording. Stored on-device with SwiftData.
@Model
final class MomentLog {
    /// Matches `InteractionMoment.id`.
    var momentID: String
    var completedAt: Date

    init(momentID: String, completedAt: Date = .now) {
        self.momentID = momentID
        self.completedAt = completedAt
    }

    /// The moment this log refers to, or `nil` if it's no longer in the library.
    /// Main-actor because the library is, like the views that display it.
    @MainActor var moment: InteractionMoment? {
        MomentLibrary.moment(withID: momentID)
    }
}
