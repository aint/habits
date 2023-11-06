import Foundation

extension Date {

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        if component == .quarter {
            switch calendar.component(.month, from: self) {
            case 1,2,3: return 1
            case 4,5,6: return 2
            case 7,8,9: return 3
            default: return 4 // 10,11,12
            }
        }
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

    var startOfQuarter: Date {
         let startOfMonth = Calendar.current.date(
            from: Calendar.current.dateComponents([.year, .month],
            from: Calendar.current.startOfDay(for: self))
         )!

         var components = Calendar.current.dateComponents([.month, .day, .year], from: startOfMonth)

         switch components.month! {
         case 1,2,3: components.month = 1
         case 4,5,6: components.month = 4
         case 7,8,9: components.month = 7
         default: components.month = 10 // 10,11,12
         }
         return Calendar.current.date(from: components)!
     }

    static func past(_ count: Int, _ component: Calendar.Component) -> [Date] {
        let today = Date()
        var entries: [Date] = []
        for index in 0...count - 1 {
            let date = component == .quarter 
                ? Calendar.current.date(byAdding: .month, value: -index*3, to: today)!.startOfQuarter // workaround for unimplemented quarter component
                : Calendar.current.date(byAdding: component, value: -index, to: today)!
            entries.append(date)
        }
        return entries
    }

    var withoutTime: Date {
        return Calendar.current.startOfDay(for: self)
    }

}
