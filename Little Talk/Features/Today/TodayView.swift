import SwiftUI

/// The Today tab: a welcoming header and one featured interaction moment.
struct TodayView: View {
    @State private var baby = BabyProfile.placeholder
    @State private var featuredMoment = MomentLibrary.featured
    @State private var isChoosingMoment = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.extraLarge) {
                    TodayHeaderView(baby: baby)
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
                MomentPickerView(selection: $featuredMoment)
            }
        }
    }
}

#Preview("Light") {
    TodayView()
}

#Preview("Dark") {
    TodayView()
        .preferredColorScheme(.dark)
}
