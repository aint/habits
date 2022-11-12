import SwiftUI
import Charts

struct HistoryChartView: View {
    let habit: Habit

    var body: some View {
        Chart {
            ForEach(ChartEntry.last12MonthsCount(habit.entries)) { entry in
                BarMark(
                    x: .value("Period", entry.label),
                    y: .value("Count", entry.value)
                )
                .annotation(position: .top) {
                    Text("\(Int(entry.value))")
                        .font(.footnote)
                        .foregroundColor(habit.uiColor)
                }
            }
        }
        .padding(.top)
        .chartYAxis(.hidden)
        .multilineTextAlignment(.center)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryChartView(habit: Habit.sampleData[0])
    }
}
