# NavigationSearchBarModifier

[![Build for the latest iOS](https://github.com/stleamist/NavigationSearchBarModifier/workflows/Build%20for%20the%20latest%20iOS/badge.svg)](https://github.com/stleamist/NavigationSearchBarModifier/actions?query=workflow%3A%22Build+for+the+latest+iOS%22)
[![Build for iOS 14 beta](https://github.com/stleamist/NavigationSearchBarModifier/workflows/Build%20for%20iOS%2014%20beta/badge.svg)](https://github.com/stleamist/NavigationSearchBarModifier/actions?query=workflow%3A%22Build+for+iOS+14+beta%22)

A clean way to attach a search bar with a scope bar in SwiftUI.

## Usage
```swift
import SwiftUI
import NavigationSearchBarModifier

struct GroceryList: View {
    
    let groceries: [Grocery]
    @State private var searchControllerIsPresented = false
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
                searchControllerIsPresented: $searchControllerIsPresented,
                searchTerm: $searchTerm,
                searchScopes: scopes,
                selectedSearchScope: $selectedScope,
                hidesWhenScrolling: true
            )
        }
    }
}
```
