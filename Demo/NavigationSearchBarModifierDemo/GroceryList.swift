import SwiftUI
import NavigationSearchBarModifier

struct GroceryList: View {
    
    enum Scope: String, CaseIterable {
        case all
        case fruit
        case vegetable
    }
    
    let groceries: [Grocery] = sampleGroceries
    @State private var searchControllerIsPresented = false
    @State private var searchTerm: String?
    private var scopes: [String] = Scope.allCases.map(\.rawValue)
    @State private var selectedScope: Int = 0
    
    private var searchTermPredicate: (Grocery) -> Bool {
        if let searchTerm = searchTerm, !searchTerm.isEmpty {
            return { grocery in
                grocery.name.localizedCaseInsensitiveContains(searchTerm)
            }
        } else {
            return { _ in true }
        }
    }
    
    private var categoryPredicate: (Grocery) -> Bool {
        let selectedScopeRawValue = scopes[selectedScope]
        let selectedScope = Scope(rawValue: selectedScopeRawValue)!
        
        switch selectedScope {
        case .all: return { _ in true }
        case .fruit: return { grocery in grocery.category == .fruit }
        case .vegetable: return { grocery in grocery.category == .vegetable }
        }
    }
    
    private var filteredGroceries: [Grocery] {
        var groceries = self.groceries
        if searchControllerIsPresented {
            groceries = groceries.filter(searchTermPredicate)
            groceries = groceries.filter(categoryPredicate)
        }
        return groceries
    }
    
    var body: some View {
        NavigationView {
            List(filteredGroceries) { grocery in
                GroceryRow(grocery: grocery)
            }
            .navigationBarTitle("Groceries")
            .navigationSearchBar(
                searchControllerIsPresented: $searchControllerIsPresented,
                placeholder: "Search groceries",
                searchTerm: $searchTerm,
                searchScopes: scopes,
                selectedSearchScope: $selectedScope,
                hidesWhenScrolling: true
            )
        }
    }
}

struct GroceryList_Previews: PreviewProvider {
    static var previews: some View {
        GroceryList()
    }
}
