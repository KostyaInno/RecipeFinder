import SwiftUI

struct LoginView: View {
    @State var viewModel: LoginViewModel
    let onLogin: () -> Void
    let onGuest: () -> Void
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            VStack(spacing: 24) {
                Text(Strings.loginTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                formFields
                loginButton
                guestButton
            }
            .padding(32)
        }
    }
    
    private var formFields: some View {
        Group {
            TextField(Strings.usernamePlaceholder, text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            SecureField(Strings.passwordPlaceholder, text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
    
    private var loginButton: some View {
        Button(action: {
            Task {
                await viewModel.login()
                if viewModel.errorMessage == nil {
                    onLogin()
                }
            }
        }) {
            if viewModel.isLoading {
                ProgressView()
            } else {
                Text(Strings.loginButton)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .disabled(viewModel.isLoading)
    }
    
    private var guestButton: some View {
        Button(action: {
            viewModel.loginAsGuest()
            onGuest()
        }) {
            Text(Strings.loginContinueAsGuest)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(Color.secondary)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary, lineWidth: 2)
                )
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(authManager: AuthManager(credentialsManager: CredentialsManager())), onLogin: {}, onGuest: {})
} 
