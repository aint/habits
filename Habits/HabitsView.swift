import SwiftUI

struct HabitsView: View {
    @State private var isPresentingNewHabitView = false
    @State private var newHabit = Habit()
    @Binding var habits: [Habit]

    var body: some View {
        List {
            HStack{
                Spacer()
                Label("Mon\n1", systemImage: "")
                    .labelStyle(.titleOnly)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                Label("Tue\n2", systemImage: "")
                    .labelStyle(.titleOnly)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                Label("Wed\n3", systemImage: "")
                    .labelStyle(.titleOnly)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                Label("Thu\n4", systemImage: "")
                    .labelStyle(.titleOnly)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                Label("Fri\n5", systemImage: "")
                    .labelStyle(.titleOnly)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.trailing)
            }
            ForEach($habits) { $habit in
                NavigationLink(destination: HabitDetailView(habit: $habit)) {
                    HabitSummaryView(habit: habit)
                }
            }
        }
        .navigationTitle("Habits")
        .toolbar {
            Button(action: {
                isPresentingNewHabitView = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewHabitView) {
            NavigationView {
                HabitEditView(habit: $newHabit)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewHabitView = false
                                newHabit = Habit()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                habits.append(newHabit)
                                isPresentingNewHabitView = false
                                newHabit = Habit()
                            }
                        }
                    }
            }
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HabitsView(habits: .constant(Habit.sampleData))
        }
    }
}

