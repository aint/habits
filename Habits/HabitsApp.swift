//
//  HabitsApp.swift
//  Habits
//
//  Created by Oleksandr T on 10.09.2022.
//

import SwiftUI

@main
struct HabitsApp: App {
    @StateObject private var store = HabitStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HabitsView(habits: $store.habits) {
                    Task {
                        do {
                            try await HabitStore.save(habits: store.habits)
                        } catch {
                            fatalError("Error saving habits.")
                        }
                    }
                }
            }
            .task {
                do {
                    store.habits = try await HabitStore.load()
                } catch {
                    fatalError("Error loading habits.")
                }
            }
        }
    }
}
