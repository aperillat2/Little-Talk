import SwiftUI

/// Form sections for editing the baby's profile.
///
/// Shared by the welcome screen and Settings so both stay consistent.
/// Place inside a `Form`.
struct BabyProfileFields: View {
    @Binding var profile: BabyProfile

    var body: some View {
        Section {
            TextField("Name", text: $profile.name, prompt: Text("Name (optional)"))
                .textContentType(.givenName)
                .textInputAutocapitalization(.words)

            DatePicker(
                "Birth date",
                selection: $profile.birthDate,
                in: Self.birthDateRange,
                displayedComponents: .date
            )
        } header: {
            Text("Your baby")
        }

        Section {
            Toggle("Born early?", isOn: isBornEarly)

            if profile.dueDate != nil {
                DatePicker(
                    "Due date",
                    selection: dueDate,
                    in: dueDateRange,
                    displayedComponents: .date
                )
            }
        } footer: {
            Text("If your baby arrived before their due date, LittleTalk uses their adjusted age to suggest moments that fit where they are developmentally.")
        }
        .onChange(of: profile.birthDate) { _, newBirthDate in
            // Keep the due date valid if the birth date moves past it.
            if let due = profile.dueDate, due <= newBirthDate {
                profile.dueDate = Self.defaultDueDate(for: newBirthDate)
            }
        }
    }

    // MARK: - Bindings

    private var isBornEarly: Binding<Bool> {
        Binding {
            profile.dueDate != nil
        } set: { bornEarly in
            profile.dueDate = bornEarly ? Self.defaultDueDate(for: profile.birthDate) : nil
        }
    }

    /// Only used while the due date picker is visible, so `dueDate` is set.
    private var dueDate: Binding<Date> {
        Binding {
            profile.dueDate ?? Self.defaultDueDate(for: profile.birthDate)
        } set: { newValue in
            profile.dueDate = newValue
        }
    }

    // MARK: - Ranges

    /// Up to three years back, so older siblings' details are still accepted.
    private static var birthDateRange: ClosedRange<Date> {
        let earliest = Calendar.current.date(byAdding: .year, value: -3, to: .now) ?? .now
        return earliest ... .now
    }

    /// From the day after birth to 20 weeks later (born at around 20 weeks).
    private var dueDateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let start = calendar.date(byAdding: .day, value: 1, to: profile.birthDate) ?? profile.birthDate
        let end = calendar.date(byAdding: .weekOfYear, value: 20, to: profile.birthDate) ?? start
        return start ... end
    }

    private static func defaultDueDate(for birthDate: Date) -> Date {
        Calendar.current.date(byAdding: .weekOfYear, value: 4, to: birthDate) ?? birthDate
    }
}

#Preview {
    @Previewable @State var profile = BabyProfile.preview
    Form {
        BabyProfileFields(profile: $profile)
    }
    .tint(Theme.Colors.accent)
}
