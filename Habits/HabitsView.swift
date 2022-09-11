import SwiftUI

struct HabitsView: View {
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
            Button(action: {}) {
                Image(systemName: "plus")
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

