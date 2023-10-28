import SwiftUI

struct HabitDetailView: View {
    @State private var updateHabit: Habit = Habit()
    @State private var isPresentingEditView = false
    
    @Binding var habit: Habit
    
    var body: some View {
        List {
            Section(header: Text("Overview")) {
                HStack {
                    Label("Score", systemImage: "gamecontroller")
                    Spacer()
                    Text("\(habit.computeScore(), specifier: "%.1f")%")
                        .padding(4)
                        .cornerRadius(4)
                }
                .foregroundColor(habit.uiColor)
                HStack {
                    Label("Month", systemImage: "goforward.30")
                    Spacer()
                    Text("\(habit.entryCount(.month))")
                        .padding(4)
                        .cornerRadius(4)
                }
                .foregroundColor(habit.uiColor)
                HStack {
                    Label("Year", systemImage: "calendar")
                    Spacer()
                    Text("\(habit.entryCount(.year))")
                        .padding(4)
                        .cornerRadius(4)
                }
                .foregroundColor(habit.uiColor)
                HStack {
                    Label("Total", systemImage: "a.circle")
                    Spacer()
                    Text("\(habit.entryCount(nil))")
                        .padding(4)
                        .cornerRadius(4)
                }
                .foregroundColor(habit.uiColor)
            }
            Section(header: Text("Score")) {
                ScoreChartView(habit: habit)
                    .frame(minHeight: 200)
                    .foregroundColor(habit.uiColor)
            }
            Section(header: Text("History")) {
                HistoryChartView(habit: habit)
                    .frame(minHeight: 250)
                    .foregroundColor(habit.uiColor)
            }
            Section(header: Text("Calendar")) {
            }
        }
        .navigationTitle(habit.name)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                updateHabit = habit
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                HabitEditView(habit: $updateHabit)
                    .navigationTitle(habit.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                habit.update(from: updateHabit)
                            }
                        }
                    }
            }
        }
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HabitDetailView(habit: .constant(Habit.sampleData[0]))
        }
    }
}
