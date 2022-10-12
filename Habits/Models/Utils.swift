import Foundation

extension Date {

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

    var weekdayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }

    var monthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: self)
    }

    static func past(_ count: Int, _ component: Calendar.Component) -> [Date] {
        let today = Date()
        var entries: [Date] = []
        for index in 0...count - 1 {
            let date = Calendar.current.date(byAdding: component, value: -index, to: today)!
            entries.append(date)
        }
        return entries
    }

    var withoutTime: Date {
        return Calendar.current.startOfDay(for: self)
    }

}
