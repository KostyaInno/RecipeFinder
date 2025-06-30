import SwiftUI

struct ContentView: View {
    @State private var coordinator = AppCoordinator(dependencies: .live)
    
    var body: some View {
        Group {
            switch coordinator.currentScreen {
            case .splash:
                SplashView {
                    coordinator.onSplashFinished()
                }
            case .login:
                coordinator.makeLoginModule(
                    onLogin: {
                        coordinator.login()
                    },
                    onGuest: {
                        coordinator.login()
                    }
                )
            case .recipeList:
                coordinator.makeRecipeListModule()
            }
        }
        .animation(.easeInOut, value: coordinator.currentScreen)
        .transition(.opacity)
    }
}

#Preview {
    ContentView()
} 
