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

    static func last12MonthsCount(_ habitEntries: [Date: Entry]) -> [ChartEntry] {
        var entries: [ChartEntry] = []
        for (index, date) in Date.past(12, .month).reversed().enumerated() {
            var label = date.monthName
            if index == 0 || date.get(.month) == 1 {
                label = "\(label)\n\(date.get(.year))"
            }

            var count = 0
            for habitDate in habitEntries.keys {
                if habitDate.get(.month) == date.get(.month) {
                    count += 1
                }
            }

            let entry = ChartEntry(label: label, value: Double(count))
            entries.append(entry)
        }
        return entries
    }

    static func render(_ habitEntries: [Date: Entry], _ grouping: ChartGrouping) -> [ChartEntry] {
        var entries: [ChartEntry] = []
        let calComponent = grouping.info.component
        for (index, date) in Date.past(10, calComponent).reversed().enumerated() {

            var label: String
            switch calComponent {
            case .weekOfYear:
                label = "W" + String(date.get(calComponent))
            case .month:
                label = date.monthName
            case .quarter:
                switch date.get(.month) {
                case 1,2,3: label = "Q1"
                case 4,5,6: label = "Q2"
                case 7,8,9: label = "Q3"
                case 10,11,12: label = "Q4"
                default: label = "Q"
                }
            case .year:
                label = String(date.get(calComponent))
            default:
                label = ""
            }

            if (index == 0 || date.get(calComponent) == 1) && calComponent != .year {
                label = "\(label)\n\(date.get(.year))"
            }

            var count = 0
            for habitDate in habitEntries.keys {
                if habitDate.get(calComponent) == date.get(calComponent) {
                    count += 1
                }
            }

            let entry = ChartEntry(label: label, value: Double(count))
            entries.append(entry)
        }
        return entries
    }

    static func scoreForLast15Days(_ habitEntries: [Date: Entry]) -> [ChartEntry] {
        var entries: [ChartEntry] = []
        var score = 0.0
        for (index, date) in Date.past(15, .day).reversed().enumerated() {
            var label = String(date.get(.day))
            if index == 0 || date.get(.day) == 1 {
                label = "\(label)\n\(date.monthName)"
            }

            let value = habitEntries[date.withoutTime]?.value ?? 0.0
            score = Habit.computeScore(score, value)

            let entry = ChartEntry(label: label, value: score * 100)
            entries.append(entry)
        }
        return entries
    }

}

enum ChartGrouping: CaseIterable {
    case week
    case month
    case quarter
    case year

    var info: (component: Calendar.Component, text: String) {
        switch self {
        case .week:
            return (.weekOfYear, "Week")
        case .month:
            return (.month, "Month")
        case .quarter:
            return (.quarter, "Quarter")
        case .year:
            return (.year, "Year")
        }
    }
}
