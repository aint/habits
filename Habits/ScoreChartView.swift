import SwiftUI
import Charts

struct ScoreChartView: View {

    var body: some View {
        Chart(ChartEntry.last12Months()) {
            LineMark(
                x: .value("Period", $0.label),
                y: .value("Score", $0.value)
            )
            .symbol(.circle)
        }
        .padding(.top)
        .multilineTextAlignment(.center)
        .chartYScale(domain: ClosedRange(uncheckedBounds: (lower: 0, upper: 100)))
    }
}

struct ScoreChartView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreChartView()
    }
}
