import Foundation

struct ChartEntry: Identifiable {
    var id = UUID()
    var label: String
    var value: Double

    static func last12Months() -> [ChartEntry] {
        var entries: [ChartEntry] = []
        for (index, date) in Date.past(12, .month).reversed().enumerated() {
            var label = date.monthName
            if index == 0 || date.get(.month) == 1 {
                label = "\(label)\n\(date.get(.year))"
            }
            let entry = ChartEntry(label: label, value: Double(index) + 20)
            entries.append(entry)
        }
        return entries
    }
}
