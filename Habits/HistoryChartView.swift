import SwiftUI
import Charts

struct HistoryChartView: View {

    var body: some View {
        Chart {
            ForEach(ChartEntry.last12Months()) { entry in
                BarMark(
                    x: .value("Period", entry.label),
                    y: .value("Count", entry.value)
                )
                .annotation(position: .top) {
                    Text("\(Int(entry.value))")
                        .font(.footnote)
                        .foregroundColor(.blue) // TODO: set habit color
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
        HistoryChartView()
    }
}
