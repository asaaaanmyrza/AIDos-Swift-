import SwiftUI

struct MainView: View {
    @State var text: String = ""
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                VStack {
                    header()
                    ScrollView {
                        VStack {
                            VStack (spacing: 15) {
                                HStack (spacing:15) {
                                    hotKeyButton(for: AuthView(), color: .red, text:"Перезайти")
                                    hotKeyButton(for: ChatsListView(), color: .yellow, text: "Ваши чаты")
                                }
                                HStack (spacing:15) {
                                    hotKeyButton(for: TarlanView(), color: .green, text:"Тарлан")
                                    hotKeyButton(for: TarlanView(), color: .blue, text:"точно не тарлан")
                                }
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(.red)
                                    .frame(width: 330, height: 300)
                                
                            }
                            .padding(20)
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

extension MainView {
    //HOTKEY NAVIGATION BUTTON
    func hotKeyButton<T: View>(
        for destination: T,
        color: Color = .accentPurple,
        textColor: Color = .white,
        text: String
    ) -> some View {
        return HStack (spacing: 15) {
            NavigationLink(destination: destination) {
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(LinearGradient(
                            colors: [
                                color.opacity(0.8),
                                color
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                    Text(text)
                        .foregroundStyle(textColor)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .frame(width: 160, height:110)
            }
        }
    }
    
    //HEADER
    func header() -> some View {
        return ZStack (alignment: .top) {
            RoundedRectangle(cornerRadius: 60)
                .fill(LinearGradient(
                    colors: [
                        .accentPurple.opacity(0.8),
                        .accentPurple
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .frame(width: .infinity, height: 500)
                .frame(height: 285, alignment: .bottom)
                .clipped()
            VStack (alignment: .leading) {
                Text("Добрый вечер,")
                    .font(Font.title)
                    .foregroundStyle(Color.white)
                Text("asan")
                    .font(Font.largeTitle)
                    .bold()
                    .foregroundStyle(Color.white)
                Text("Как вы себя чувствуете?")
                    .font(Font.title)
                    .foregroundStyle(Color.white)
                HStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.3))
                        .frame(width:75, height: 75)
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.3))
                        .frame(width:75, height: 75)
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.3))
                        .frame(width:75, height: 75)
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.3))
                        .frame(width:75, height: 75)
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 60)
        }
    }
}

#Preview {
    MainView()
}
