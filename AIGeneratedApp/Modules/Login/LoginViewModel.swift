import Foundation
import Observation

@Observable
final class LoginViewModel {
    private let authManager: AuthManaging
    
    var username: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    init(authManager: AuthManaging) {
        self.authManager = authManager
    }
    
    @MainActor
    func login() async {
        isLoading = true
        errorMessage = nil
        let credentials = UserCredentials(username: username, password: password)
        do {
            try await authManager.login(credentials: credentials)
        } catch {
            if let authError = error as? AuthError {
                errorMessage = authError.localizedDescription
            } else {
                errorMessage = error.localizedDescription
            }
        }
        isLoading = false
    }
    
    func loginAsGuest() {
        authManager.loginAsGuest()
    }
} 