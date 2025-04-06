import SwiftUI

struct FavoriteView: View {
    @State var searchText:String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView{
                ForEach(0..<3, id: \.self){ i in
                    FavoriteCardView()
                }
            }.searchable(text: $searchText)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Filter Menu")
        }
    }
}

#Preview {
    FavoriteView()
}
