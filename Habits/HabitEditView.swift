import SwiftUI

struct HabitEditView: View {
    @Binding var habit: Habit

    var color: Binding<Color> {
        Binding {
            return habit.uiColor
        } set: { newColor in
            habit.color = Habit.CodableColor(color: newColor)
        }
    }

    var body: some View {
        Form {
            Section(header: Text("Edit habit")) {
                TextField("Name", text: $habit.name)
                ColorPicker("Color", selection: self.color)
            }
        }
    }
}

struct HabitEditView_Previews: PreviewProvider {
    static var previews: some View {
        HabitEditView(habit: .constant(Habit.sampleData[0]))
    }
}
