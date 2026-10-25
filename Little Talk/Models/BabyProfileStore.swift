import Foundation
import Observation

/// Loads and saves the baby's profile on this device.
///
/// Shared through the SwiftUI environment so every screen reads the same
/// profile. Stored as JSON in `UserDefaults`; it's a single small record,
/// so a database isn't needed yet.
@Observable
final class BabyProfileStore {
    /// `nil` until the parent completes the welcome screen.
    private(set) var profile: BabyProfile?

    /// `nil` keeps everything in memory (used by previews and tests).
    private let defaults: UserDefaults?
    private static let storageKey = "babyProfile"

    init(defaults: UserDefaults? = .standard) {
        self.defaults = defaults
        self.profile = Self.load(from: defaults)
    }

    /// An in-memory store for previews and tests. Never touches disk.
    init(inMemoryProfile profile: BabyProfile?) {
        self.defaults = nil
        self.profile = profile
    }

    func save(_ profile: BabyProfile) {
        self.profile = profile
        guard let defaults else { return }
        do {
            defaults.set(try JSONEncoder().encode(profile), forKey: Self.storageKey)
        } catch {
            // Encoding a plain struct shouldn't fail; surface it in debug builds.
            assertionFailure("Failed to save baby profile: \(error)")
        }
    }

    private static func load(from defaults: UserDefaults?) -> BabyProfile? {
        guard let data = defaults?.data(forKey: storageKey) else { return nil }
        return try? JSONDecoder().decode(BabyProfile.self, from: data)
    }
}

extension BabyProfile {
    /// Sample profile for previews: an 8-month-old named Maya.
    static var preview: BabyProfile {
        let birthDate = Calendar.current.date(byAdding: .month, value: -8, to: .now) ?? .now
        return BabyProfile(name: "Maya", birthDate: birthDate)
    }
}
