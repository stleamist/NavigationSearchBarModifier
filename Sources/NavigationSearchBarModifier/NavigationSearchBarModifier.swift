import SwiftUI

struct NavigationSearchBarHosting: UIViewControllerRepresentable {
    
    @Binding var searchTerm: String?
    var scopes: [String]?
    @Binding var selectedScope: Int
    
    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        uiViewController.parent?.navigationItem.searchController = context.coordinator.searchController
        uiViewController.parent?.navigationItem.hidesSearchBarWhenScrolling = false
        
        context.coordinator.searchController.searchBar.text = searchTerm
        context.coordinator.searchController.searchBar.scopeButtonTitles = scopes
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate, UISearchResultsUpdating {
        
        var parent: NavigationSearchBarHosting
        let searchController: UISearchController
        
        init(_ navigationSearchBarHosting: NavigationSearchBarHosting) {
            self.parent = navigationSearchBarHosting
            self.searchController = UISearchController()
            super.init()
            setupSearchController()
        }
        
        private func setupSearchController() {
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.showsScopeBar = true
            searchController.searchBar.delegate = self
        }
        
        // UISearchResultsUpdating
        func updateSearchResults(for searchController: UISearchController) {
            parent.searchTerm = searchController.searchBar.text
        }
        
        // UISearchBarDelegate
        func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            parent.selectedScope = selectedScope
        }
    }
}

struct NavigationSearchBarModifier: ViewModifier {
    
    @Binding var searchTerm: String?
    var scopes: [String]?
    @Binding var selectedScope: Int
    
    func body(content: Content) -> some View {
        content.background(
            NavigationSearchBarHosting(
                searchTerm: $searchTerm,
                scopes: scopes,
                selectedScope: $selectedScope
            )
        )
    }
}

public extension View {
    
    func navigationSearchBar(
        searchTerm: Binding<String?>
    ) -> some View {
        self.modifier(
            NavigationSearchBarModifier(
                searchTerm: searchTerm,
                scopes: nil,
                selectedScope: .constant(0)
            )
        )
    }
    
    func navigationSearchBar(
        searchTerm: Binding<String?>,
        scopes: [String]?,
        selectedScope: Binding<Int>
    ) -> some View {
        self.modifier(
            NavigationSearchBarModifier(
                searchTerm: searchTerm,
                scopes: scopes,
                selectedScope: selectedScope
            )
        )
    }
}
