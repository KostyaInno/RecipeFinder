import Foundation

struct AppDependencies {
    let credentialsManager: CredentialsManaging
    let authManager: AuthManaging
    let apiManager: APIManaging
    let recipeRepository: RecipeRepositoryProtocol

    static let live = AppDependencies(
        credentialsManager: CredentialsManager(),
        authManager: AuthManager(credentialsManager: CredentialsManager()),
        apiManager: APIManager(),
        recipeRepository: RecipeRepository(apiManager: APIManager())
    )
}
