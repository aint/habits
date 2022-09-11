//
//  HabitsApp.swift
//  Habits
//
//  Created by Oleksandr T on 10.09.2022.
//

import SwiftUI

@main
struct HabitsApp: App {
    @State private var habits = Habit.sampleData
    
    var body: some Scene {
        WindowGroup {
            HabitsView(habits: $habits)
        }
    }
}
