import Foundation
import Observation

@Observable
final class ProfileViewModel {
    var username: String? = nil
    private let credentialsManager: CredentialsManaging
    private let authManager: AuthManaging
    private let onLogout: () -> Void
    
    var isGuest: Bool {
        AuthManager.isGuestUser()
    }
    
    init(credentialsManager: CredentialsManaging, authManager: AuthManaging, onLogout: @escaping () -> Void) {
        self.credentialsManager = credentialsManager
        self.authManager = authManager
        self.onLogout = onLogout
        loadUsername()
    }
    
    private func loadUsername() {
        guard let credentials = credentialsManager.getCredentials() else {
            username = nil
            return
        }
        username = credentials.username
    }
    
    func logout() {
        authManager.logout()
        credentialsManager.deleteCredentials()
        onLogout()
    }
} 