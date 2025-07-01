import Foundation
import Observation

@Observable
final class ProfileViewModel {
    var email: String? = nil
    private let credentialsManager: CredentialsManaging
    private let authManager: AuthManaging
    private let onLogout: () -> Void
    
    init(credentialsManager: CredentialsManaging, authManager: AuthManaging, onLogout: @escaping () -> Void) {
        self.credentialsManager = credentialsManager
        self.authManager = authManager
        self.onLogout = onLogout
        loadEmail()
    }
    
    private func loadEmail() {
        guard let credentials = credentialsManager.getCredentials() else {
            email = nil
            return
        }
        email = credentials.username
    }
    
    func logout() {
        authManager.logout()
        credentialsManager.deleteCredentials()
        onLogout()
    }
} 