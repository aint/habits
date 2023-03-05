import SwiftUI
import Charts

struct HistoryChartView: View {
    let habit: Habit

    @State private var selectionGrouping = ChartGrouping.week

    var body: some View {
        VStack{
            Picker("", selection: $selectionGrouping) {
                ForEach(ChartGrouping.allCases, id: \.self) { grouping in
                    Text(grouping.info.text)
                }
            }

            Chart {
                ForEach(ChartEntry.render(habit.entries, selectionGrouping)) { entry in
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
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryChartView(habit: Habit.sampleData[0])
    }
}
