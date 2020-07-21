import SwiftUI

struct GroceryRow: View {
    
    var grocery: Grocery
    
    var body: some View {
        HStack {
            Text(grocery.emoji)
                .font(.title)
            VStack(alignment: .leading) {
                Text(grocery.name)
                    .font(.body)
                    .foregroundColor(.primary)
                Text(grocery.category.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct GroceryRow_Previews: PreviewProvider {
    static var previews: some View {
        GroceryRow(grocery: sampleGroceries[0])
    }
}
