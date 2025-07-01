import Foundation
import Observation
import SwiftUI

enum AppScreen {
    case splash
    case login
    case mainTabs
}

@Observable
final class AppCoordinator {
    var currentScreen: AppScreen = .splash
    var isLoggedIn: Bool = false
    let dependencies: AppDependencies

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
        currentScreen = .splash
    }

    private func checkInitialLoginState() {
        let hasCredentials = dependencies.credentialsManager.getCredentials() != nil
        let isGuest = AuthManager.isGuestUser()
        isLoggedIn = hasCredentials || isGuest
        currentScreen = isLoggedIn ? .mainTabs : .login
    }

    func proceedFromSplash() {
        checkInitialLoginState()
    }

    func onSplashFinished() {
        proceedFromSplash()
    }

    func login() {
        isLoggedIn = true
        currentScreen = .mainTabs
    }

    func logout() {
        isLoggedIn = false
        currentScreen = .login
    }
}

extension AppCoordinator {
    func makeLoginModule(onLogin: @escaping () -> Void, onGuest: @escaping () -> Void) -> some View {
        let viewModel = LoginViewModel(authManager: dependencies.authManager)
        return LoginView(viewModel: viewModel, onLogin: onLogin, onGuest: onGuest)
    }

    func makeMainTabModule() -> some View {
        let mainTabCoordinator = MainTabCoordinator(dependencies: dependencies, onLogout: { [weak self] in self?.logout() })
        return MainTabView(coordinator: mainTabCoordinator)
    }

    func makeRecipeListModule() -> some View {
        let coordinator = RecipeListCoordinator(
            recipeRepository: dependencies.recipeRepository,
            favoritesRepository: dependencies.favoritesRepository
        )
        return coordinator.makeRecipeListView()
    }
}
