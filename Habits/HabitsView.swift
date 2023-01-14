import SwiftUI

struct HabitsView: View {
    @State private var isPresentingNewHabitView = false
    @State private var newHabit = Habit()
    @Binding var habits: [Habit]

    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void

    var body: some View {
        List {
            VStack {
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Spacer()
                        ForEach(Date.past(4, .day), id: \.self) { date in
                            Label("\(date.weekdayName)\n\(date.get(.day))", systemImage: "")
                                .labelStyle(.titleOnly)
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                                .padding(.leading)
                        }
                    }
                }
            }
            ForEach($habits) { $habit in
                NavigationLink(destination: HabitDetailView(habit: $habit)) {
                    HabitSummaryView(habit: $habit)
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
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HabitsView(habits: .constant(Habit.sampleData), saveAction: {})
        }
    }
}

