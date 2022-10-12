import Foundation

struct Entry: Identifiable, Codable {
    let id: UUID
    var date: Date
    var value: Float

    init(id: UUID = UUID(), date: Date, value: Float) {
        self.id = id
        self.date = date
        self.value = value
    }

}
