import Foundation

/// Basic information about the baby.
///
/// For now this is a placeholder value; it will eventually be derived from a
/// birth date the parent enters during onboarding.
struct BabyProfile: Hashable {
    var ageInMonths: Int

    static let placeholder = BabyProfile(ageInMonths: 8)
}
