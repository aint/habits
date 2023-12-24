import SwiftUI
import Charts

struct ScoreChartView: View {
    let habit: Habit

    @State private var selectionGrouping = ChartGrouping.week

    var body: some View {
        VStack{
            Picker("", selection: $selectionGrouping) {
                ForEach(ChartGrouping.allCases, id: \.self) { grouping in
                    Text(grouping.info.text)
                }
            }
            Chart(ChartEntry.renderAll(habit.entries, selectionGrouping, .score)) {
                LineMark(
                    x: .value("Period", $0.label),
                    y: .value("Score", $0.value)
                )
                .symbol(.circle)
            }
            .padding(.top)
            .multilineTextAlignment(.center)
            .chartYScale(domain: ClosedRange(uncheckedBounds: (lower: 0, upper: 100)))
            .chartXAxis() {
                AxisMarks { value in
                    let strValue = value.as(String.self)!
                    if strValue.contains("Q") {
                        let index = strValue.index(strValue.startIndex, offsetBy: 4) // to avoid duplication, the quarter starts with the year, so we need to remove the first 4 chars
                        AxisValueLabel { Text(strValue[index...]) }
                    } else {
                        AxisValueLabel { Text(strValue) }
                    }
                }
            }
        }
    }
}

struct ScoreChartView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreChartView(habit: Habit.sampleData[0])
    }
}
