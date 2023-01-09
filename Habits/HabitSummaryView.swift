import SwiftUI

struct HabitSummaryView: View {
    private static let positiveIcon = "checkmark"
    private static let negativeIcon = "multiply"

    @Binding var habit: Habit
    
    var body: some View {
        HStack {
            Label("\(habit.name)", systemImage: "circle.dashed")
                .font(.headline)
            Spacer()
            ForEach(Date.past(4, .day), id: \.self) { date in
                Image(systemName: getIconOrDefault(date))
                    .padding(.leading)
                    .onTapGesture {
                        if habit.checkEntry(date: date) {
                            habit.deleteEntry(date: date)
                            return
                        }
                        habit.addEntry(date: date)
                    }
            }
        }
        .font(.body)
        .foregroundColor(habit.uiColor)
//        .padding([.trailing])
    }

    func getIconOrDefault(_ date: Date) -> String {
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
