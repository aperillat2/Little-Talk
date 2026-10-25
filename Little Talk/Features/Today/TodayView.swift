import SwiftUI

/// The Today tab: a welcoming header and one featured interaction moment.
struct TodayView: View {
    let profile: BabyProfile

    /// The day Today is showing. Refreshed when the app returns to the
    /// foreground on a new day, so the age and featured moment stay current.
    @State private var today = Date.now
    /// A moment the parent picked by hand. Cleared on a new day or when the
    /// profile changes, so the age-based suggestion takes over again.
    @State private var chosenMoment: InteractionMoment?
    @State private var isChoosingMoment = false

    @Environment(\.scenePhase) private var scenePhase

    private var featuredMoment: InteractionMoment {
        chosenMoment ?? MomentLibrary.featuredMoment(for: profile, on: today)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.extraLarge) {
                    TodayHeaderView(profile: profile, date: today)
                    FeaturedMomentCard(moment: featuredMoment) {
                        isChoosingMoment = true
                    }
                }
                .padding(Theme.Spacing.large)
                // Keep a comfortable reading width on larger screens.
                .frame(maxWidth: 640, alignment: .leading)
                .frame(maxWidth: .infinity)
            }
            .background(Theme.Colors.background.ignoresSafeArea())
            .navigationDestination(for: InteractionMoment.self) { moment in
                MomentDetailView(moment: moment)
            }
            .sheet(isPresented: $isChoosingMoment) {
                MomentPickerView(
                    selection: selectionBinding,
                    moments: MomentLibrary.moments(for: profile, on: today)
                )
            }
            .onChange(of: scenePhase) { _, phase in
                if phase == .active, !Calendar.current.isDate(today, inSameDayAs: .now) {
                    today = .now
                    chosenMoment = nil
                }
            }
            .onChange(of: profile) {
                chosenMoment = nil
            }
        }
    }

    private var selectionBinding: Binding<InteractionMoment> {
        Binding {
            featuredMoment
        } set: { moment in
            chosenMoment = moment
        }
    }
}

// Previews apply the app tint themselves; in the app it comes from ContentView.
#Preview("Light") {
    TodayView(profile: .preview)
        .tint(Theme.Colors.accent)
}

#Preview("Dark") {
    TodayView(profile: .preview)
        .tint(Theme.Colors.accent)
        .preferredColorScheme(.dark)
}
