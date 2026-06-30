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
            VStack {
                header()
                ScrollView {
                    VStack {
                        authChooser()
                        emailField()
                        passwordField()
                        authButton(for: authType)
                            .padding(.top, 15)
                    }
                }
            }
        }
        .ignoresSafeArea()
        
    }
}

extension AuthView {
    //AUTH TYPE PICKER
    func authChooser() -> some View {
        Picker("Scenario", selection: $authType) {
            ForEach(AuthType.allCases, id: \.self) {
                Text($0.rawValue)
                    .foregroundStyle(.white)
            }
        }
        .pickerStyle(.segmented)
        .frame(width: 300)
        .padding(.bottom, 10)
    }
    //EMAIL TEXTFIELD
    func emailField() -> some View {
        TextField("Электронная почта", text: $email)
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .padding(15)
            .background(.white)
            .cornerRadius(20)
            .padding(2)
            .padding(.horizontal)
    }
    //BUTTON FOR AUTH
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
        .font(.title2)
        .frame(width: 250, height: 70, alignment: .center)
        .background(.accentPurple)
        .cornerRadius(20)
        .foregroundStyle(Color.white)
        .padding(20)
        .bold()
        .lineLimit(1)
    }
    
    //PASSWORD TEXTFIELD
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
    
    // HEADER
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
                .frame(height: 180, alignment: .bottom)
                .clipped()
            VStack {
                Text ("AI Dos")
                    .foregroundStyle(.white)
                    .bold()
                    .font(.largeTitle)
                Text ("Your mental assistant")
                    .foregroundStyle(.white)
            }
            .padding(.top, 75)
        }
    }
}

#Preview {
    AuthView()
}
