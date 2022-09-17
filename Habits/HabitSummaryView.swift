import SwiftUI

struct HabitSummaryView: View {
    let habit: Habit
    
    var body: some View {
        HStack {
            Label("\(habit.name)", systemImage: "circle.dashed")
            //  .labelStyle(.trailingIcon)
                .font(.headline)
            Spacer()
            Image(systemName: "checkmark")
            Image(systemName: "checkmark")
            Image(systemName: "multiply")
            Image(systemName: "multiply")
            Image(systemName: "checkmark")
        }
        .font(.body)
        .foregroundColor(habit.uiColor)
        .padding([.top, .bottom, .trailing])
    }
}

struct HabitSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        HabitSummaryView(habit: Habit.sampleData[0])
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
