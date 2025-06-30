import Foundation
import Observation
import SwiftUI

enum AppScreen {
    case splash
    case login
    case main
}

@Observable
final class AppCoordinator {
    var currentScreen: AppScreen = .splash
    var isLoggedIn: Bool = false
    let dependencies: AppDependencies

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
        checkInitialLoginState()
    }

    func proceedFromSplash() {
        currentScreen = isLoggedIn ? .main : .login
    }

    func onSplashFinished() {
        proceedFromSplash()
    }

    func login() {
        isLoggedIn = true
        currentScreen = .main
    }

    func logout() {
        isLoggedIn = false
        currentScreen = .login
    }

    private func checkInitialLoginState() {
        let hasCredentials = dependencies.credentialsManager.getCredentials() != nil
        let isGuest = AuthManager.isGuestUser()
        isLoggedIn = hasCredentials || isGuest
        currentScreen = isLoggedIn ? .main : .login
    }
}

extension AppCoordinator {
    func makeLoginModule(onLogin: @escaping () -> Void, onGuest: @escaping () -> Void) -> some View {
        let viewModel = LoginViewModel(authManager: dependencies.authManager)
        return LoginView(viewModel: viewModel, onLogin: onLogin, onGuest: onGuest)
    }
}
