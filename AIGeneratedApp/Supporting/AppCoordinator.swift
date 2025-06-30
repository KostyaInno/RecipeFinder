import Foundation
import Observation
import SwiftUI

enum AppScreen {
    case splash
    case login
    case recipeList
}

@Observable
final class AppCoordinator {
    var currentScreen: AppScreen = .splash
    var isLoggedIn: Bool = false
    let dependencies: AppDependencies
    private var recipeListCoordinator: RecipeListCoordinator?

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
        currentScreen = .splash
    }

    private func checkInitialLoginState() {
        let hasCredentials = dependencies.credentialsManager.getCredentials() != nil
        let isGuest = AuthManager.isGuestUser()
        isLoggedIn = hasCredentials || isGuest
        currentScreen = isLoggedIn ? .recipeList : .login
    }

    func proceedFromSplash() {
        checkInitialLoginState()
    }

    func onSplashFinished() {
        proceedFromSplash()
    }

    func login() {
        isLoggedIn = true
        currentScreen = .recipeList
    }

    func logout() {
        isLoggedIn = false
        currentScreen = .login
    }

    func makeRecipeListModule() -> some View {
        if recipeListCoordinator == nil {
            let repository = RecipeRepository(apiManager: APIManager())
            recipeListCoordinator = RecipeListCoordinator(repository: repository)
        }
        return recipeListCoordinator!.makeRecipeListView()
    }
}

extension AppCoordinator {
    func makeLoginModule(onLogin: @escaping () -> Void, onGuest: @escaping () -> Void) -> some View {
        let viewModel = LoginViewModel(authManager: dependencies.authManager)
        return LoginView(viewModel: viewModel, onLogin: onLogin, onGuest: onGuest)
    }
}
