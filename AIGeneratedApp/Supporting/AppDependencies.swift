import Foundation

struct AppDependencies {
    let credentialsManager: CredentialsManaging
    let authManager: AuthManaging

    static let live = AppDependencies(
        credentialsManager: CredentialsManager(),
        authManager: AuthManager(credentialsManager: CredentialsManager())
    )
} 