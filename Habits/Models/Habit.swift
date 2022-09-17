import Foundation
import SwiftUI

struct Habit: Identifiable, Codable {
    let id: UUID
    var name: String = ""
    var color: CodableColor = CodableColor(color: .black)
    var days: [Date : Bool] = [:]
    
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
