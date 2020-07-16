# NavigationSearchBarModifier
A clean way to attach a search bar with a scope bar in SwiftUI.

## Usage
```swift
import SwiftUI
import NavigationSearchBarModifier

struct GroceryList: View {
    
    let groceries: [Grocery]
    @State private var searchTerm: String?
    private var scopes: [String]? = ["Fruit", "Vegetable"]
    @State private var selectedScope: Int = 0
    
    private var predicate: (Grocery) -> Bool {
        if let searchTerm = searchTerm {
            return { grocery in
                grocery.name.localizedCaseInsensitiveContains(searchTerm)
            }
        } else {
            return { _ in true }
        }
    }
    
    var body: some View {
        NavigationView {
            List(groceries.filter(predicate)) { grocery in
                Text(grocery.name)
            }
            .navigationBarTitle("Groceries")
            .navigationSearchBar(
                searchTerm: $searchTerm,
                scopes: scopes,
                selectedScope: $selectedScope
            )
        }
    }
}
```
