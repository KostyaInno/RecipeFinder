import Foundation

enum AuthError: Error, LocalizedError {
    case invalidCredentials
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid username or password."
        }
    }
}

protocol AuthManaging {
    func login(credentials: UserCredentials) async throws
    func logout()
    func loginAsGuest()
}

final class AuthManager: AuthManaging {
    private let credentialsManager: CredentialsManaging
    private let guestKey = "isGuestUser"
    
    init(credentialsManager: CredentialsManaging) {
        self.credentialsManager = credentialsManager
    }
    
    func login(credentials: UserCredentials) async throws {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulate network delay
        let isValid = !credentials.username.isEmpty && !credentials.password.isEmpty
        if isValid {
            credentialsManager.saveCredentials(username: credentials.username, password: credentials.password)
            UserDefaults.standard.set(false, forKey: guestKey)
        } else {
            throw AuthError.invalidCredentials
        }
    }
    
    func logout() {
        credentialsManager.deleteCredentials()
        UserDefaults.standard.set(false, forKey: guestKey)
    }
    
    func loginAsGuest() {
        UserDefaults.standard.set(true, forKey: guestKey)
    }
    
    static func isGuestUser() -> Bool {
        UserDefaults.standard.bool(forKey: "isGuestUser")
    }
} 