import Foundation

struct Grocery: Identifiable {
    
    enum Category: String, CaseIterable {
        case fruit
        case vegetable
    }
    
    var id: UUID = UUID()
    var emoji: String
    var name: String
    var category: Category
}
