import SwiftUI

/// Sheet for picking a different moment, from those suited to the baby's age.
struct MomentPickerView: View {
    @Binding var selection: InteractionMoment
    /// The moments to offer, already filtered for the baby's age.
    let moments: [InteractionMoment]

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List(moments) { moment in
                Button {
                    selection = moment
                    dismiss()
                } label: {
                    MomentRow(moment: moment, isSelected: moment == selection)
                }
                .listRowBackground(Theme.Colors.surface)
            }
            .scrollContentBackground(.hidden)
            .background(Theme.Colors.background)
            .navigationTitle("Choose a moment")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

/// A row summarizing one moment in the picker.
private struct MomentRow: View {
    let moment: InteractionMoment
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: moment.symbolName)
                .foregroundStyle(Theme.Colors.accent)
                .frame(width: 28)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 4) {
                Text(moment.title)
                    .font(.headline)
                    .foregroundStyle(Theme.Colors.textPrimary)
                Text(moment.instruction)
                    .font(.subheadline)
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .lineLimit(2)
            }

            Spacer(minLength: 0)

            if isSelected {
                Image(systemName: "checkmark")
                    .font(.body.weight(.semibold))
                    .foregroundStyle(Theme.Colors.accent)
                    .accessibilityHidden(true)
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    MomentPickerView(
        selection: .constant(MomentLibrary.takeATurn),
        moments: MomentLibrary.moments(forAgeInMonths: 8)
    )
        .tint(Theme.Colors.accent)
}
