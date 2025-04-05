import SwiftUI

struct favoriteView: View {
    @State var searchText:String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView{
                ForEach(0..<3, id: \.self){ i in
                    favoriteCardView()
                }
            }.searchable(text: $searchText)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Filter Menu")
        }
    }
}

#Preview {
    favoriteView()
}

