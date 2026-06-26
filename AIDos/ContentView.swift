import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    var body: some View {
        ZStack (alignment: .top) {
            Color.background
            RoundedRectangle(cornerRadius: 60)
                .alignmentGuide(VerticalAlignment.center, computeValue: { _ in 350 })
                .frame(height: 400)
                .foregroundStyle(Color.accentPurple)
            VStack {
                Text("AIDos")
                    .font(Font.title)
                Text("Ментальная поддержка")
            }
            .padding(.top, 100)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
