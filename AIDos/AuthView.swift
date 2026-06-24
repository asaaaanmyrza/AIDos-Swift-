import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    
    @State var authType: AuthType = .login
    
    @State var passwordIsVisible = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.background
            RoundedRectangle(cornerRadius: 60)
                .alignmentGuide(VerticalAlignment.center, computeValue: { _ in 600 })
                .frame(height: 400)
                .foregroundStyle(Color.accentPurple)
            VStack {
                Picker("Scenario", selection: $authType) {
                    ForEach(AuthType.allCases, id: \.self) {
                        Text($0.rawValue)
                            .foregroundStyle(.white)
                    }
                }
                .pickerStyle(.segmented)
//                .colorMultiply(.accentPurple)
                .frame(width: 300)
                .padding(10)
                TextField("Электронная почта", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(15)
                    .background(.white)
                    .cornerRadius(20)
                    .padding(2)
                    .padding(.horizontal)
                passwordField()
                authButton(for: authType)
            }
        }
        .ignoresSafeArea()
        
    }
}

extension AuthView {
    func authButton(for type: AuthType) -> some View {
        return Button(type.rawValue) {
            viewModel.email = email
            viewModel.password = password
            Task {
                if type == .login {
                    await viewModel.login()
                } else {
                    await viewModel.register()
                }
                
            }
        }
        .frame(width: 200, height: 50, alignment: .center)
        .background(.accentPurple)
        .cornerRadius(20)
        .foregroundStyle(Color.white)
        .padding(20)
        .bold()
        .lineLimit(1)
    }
    
    func passwordField() -> some View {
        return ZStack (alignment: .trailing) {
            Group {
                if passwordIsVisible {
                    TextField("Пароль", text: $password)
                } else {
                    SecureField("Пароль", text: $password)
                }
            }
            .focused($isFocused)
            .textContentType(.password)
            .autocapitalization(.none)
            .padding(15)
            .background(.white)
            .cornerRadius(20)
            
            Button(action: {
                passwordIsVisible.toggle()
                isFocused = true
            }) {
                Image(systemName: passwordIsVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .padding(.bottom, 60)
        .padding(2)
    }
}

#Preview {
    AuthView()
}
