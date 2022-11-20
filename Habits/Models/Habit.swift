import Foundation
import SwiftUI

struct Habit: Identifiable, Codable {
    let id: UUID
    var name: String = ""
    var color: CodableColor = CodableColor(color: .black)
    var entries: [Date : Entry] = [:]
    
    init(id: UUID = UUID()) {
        self.id = id
    }
    
    init(id: UUID = UUID(), name: String, color: CodableColor) {
        self.id = id
        self.name = name
        self.color = color
    }
    
    mutating func update(from habit: Habit) {
        name = habit.name
        color = habit.color
    }
    
    mutating func addEntry(date: Date) {
        entries.updateValue(Entry(date: date.withoutTime, value: 1), forKey: date.withoutTime)
    }
    
    mutating func deleteEntry(date: Date) {
        entries.removeValue(forKey: date.withoutTime)
    }
    
    func checkEntry(date: Date) -> Bool {
        return entries.keys.contains(date.withoutTime)
    }
    
    func entryCount(_ component: Calendar.Component?) -> Int {
        if component == nil {
            return entries.count
        }

        var count = 0
        for date in entries.keys {
            if date.get(component!) == Date.now.get(component!) {
                count += 1
            }
        }

        return count
    }

    func computeScore() -> Double {
        return ChartEntry.scoreForLast15Days(entries).last!.value
    }

    static func computeScore(_ previousScore: Double, _ value: Double) -> Double {
        let frequency = 1.0
        let multiplier = pow(0.5, sqrt(frequency) / 13.0)
        return previousScore * multiplier + value * (1 - multiplier)
    }
}

extension Habit {
    static let sampleData: [Habit] =
    [
        Habit(name: "Abs", color: CodableColor(color: .yellow)),
        Habit(name: "Plank", color: CodableColor(color: .cyan)),
        Habit(name: "Training", color: CodableColor(color: .indigo)),
    ]

    struct CodableColor: Codable {
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0

        init(color: Color) {
            UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
    }

    var uiColor: Color {
        return Color(red: self.color.red, green: self.color.green, blue: self.color.blue)
    }
}
