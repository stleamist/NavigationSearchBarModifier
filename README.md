# NavigationSearchBarModifier

## Usage
```swift
import SwiftUI
import NavigationSearchBarModifier

struct GroceryList: View {
    
    let groceries: [Grocery]
    @State private var searchTerm: String?
    @State private var selectedScope: Int = 0
    
    var body: some View {
        NavigationView {
            List(groceries.filter({ $0.name.contains(searchTerm) })) { grocery in
                Text(grocery.name)
            }
            .navigationBarTitle("Groceries")
            .navigationSearchBar(
                searchTerm: $searchTerm,
                scopes: ["Fruit", "Vegetable"],
                selectedScope: $selectedScope
            )
        }
    }
}
```
