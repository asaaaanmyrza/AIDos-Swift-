import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    var body: some View {
        VStack {
            Text("AIDos")
                .font(Font.title)
            Spacer()
            TextField("Insert", text: $text)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
