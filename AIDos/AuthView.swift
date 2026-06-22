import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isAlreadyRegistered = true
    
    var body: some View {
        Text("Welcome")
            .font(.largeTitle)
            .bold()
        TextField("Email", text: $email)
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
        SecureField("Password", text: $password)
            .textContentType(.password)
            .autocapitalization(.none)
        if isAlreadyRegistered {
            Button("Login") {
                viewModel.email = email
                viewModel.password = password
                Task {
                    await viewModel.login()
                }
            }
        } else {
            Button("Register") {
                viewModel.email = email
                viewModel.password = password
                Task {
                    await viewModel.register()
                }
            }
        }
        Button("Haven't registered yet?") {
            isAlreadyRegistered = false
        }
    }
}

#Preview {
    AuthView()
}
