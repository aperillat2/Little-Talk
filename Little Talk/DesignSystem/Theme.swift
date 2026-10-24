import SwiftUI

/// Central place for LittleTalk's visual language.
///
/// Colors live in `Assets.xcassets` so each one carries its own light and dark
/// variant; this type just gives them readable names in code.
enum Theme {
    enum Colors {
        /// Warm off-white page background (deep warm charcoal in dark mode).
        static let background = Color("Background")
        /// Card and elevated surface color.
        static let surface = Color("Surface")
        /// Primary text: dark charcoal in light mode.
        static let textPrimary = Color("TextPrimary")
        /// Supporting text with sufficient contrast on both backgrounds.
        static let textSecondary = Color("TextSecondary")
        /// Muted sage accent used for primary actions and highlights.
        static let accent = Color("AccentColor")
        /// Soft sage tint for chips and icon backgrounds.
        static let accentSoft = Color("AccentSoft")
        /// Foreground color for content drawn on top of `accent`.
        static let onAccent = Color("OnAccent")
    }

    enum Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }

    enum Radius {
        static let card: CGFloat = 28
    }
}
