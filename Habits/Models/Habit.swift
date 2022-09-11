import Foundation
import SwiftUI

struct Habit: Identifiable {
    let id: UUID = UUID()
    var name: String = ""
    var color: Color = .black
    var days: [Date : Bool] = [:]
    
    init() {
    }
    
    init(name: String, color: Color) {
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
        Habit(name: "Abs", color: .yellow),
        Habit(name: "Plank", color: .cyan),
        Habit(name: "Training", color: .indigo),
    ]
}
