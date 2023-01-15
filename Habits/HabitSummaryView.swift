import SwiftUI

struct HabitSummaryView: View {
    private static let positiveIcon = "checkmark"
    private static let negativeIcon = "multiply"

    @Binding var habit: Habit
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack(spacing: 0) {
                    Text("\(habit.name)")
                        .frame(width: 0.6 * geometry.size.width, alignment: .leading)

                    ForEach(Date.past(4, .day), id: \.self) { date in
                        Image(systemName: getIconOrDefault(date))
                            .frame(width: 0.1 * geometry.size.width)
                            .onTapGesture {
                                if habit.checkEntry(date: date) {
                                    habit.deleteEntry(date: date)
                                    return
                                }
                                habit.addEntry(date: date)
                            }
                    }
                }
                Spacer()
            }
        }
        .foregroundColor(habit.uiColor)
        .font(.body)
    }

    func getIconOrDefault(_ date: Date) -> String { // rename
        if habit.checkEntry(date: date) {
            return HabitSummaryView.positiveIcon
        }
        return HabitSummaryView.negativeIcon
    }
}

struct HabitSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        HabitSummaryView(habit: .constant(Habit.sampleData[0]))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
