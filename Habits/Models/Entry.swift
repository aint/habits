import Foundation

struct Entry: Identifiable, Codable {
    let id: UUID
    var date: Date
    var value: Double

    init(id: UUID = UUID(), date: Date, value: Double) {
        self.id = id
        self.date = date
        self.value = value
    }

}
