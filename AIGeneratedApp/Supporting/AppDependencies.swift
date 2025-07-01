import Foundation

struct AppDependencies {
    let credentialsManager: CredentialsManaging
    let authManager: AuthManaging
    let apiManager: APIManaging
    let recipeRepository: RecipeRepositoryProtocol
    let swiftDataConfigurator: Configurable
    let favoritesStorageManager: FavoritesStorageManaging
    let favoritesRepository: FavoritesLocalRepositoryProtocol

    static let live = AppDependencies(
        credentialsManager: CredentialsManager(),
        authManager: AuthManager(credentialsManager: CredentialsManager()),
        apiManager: APIManager(),
        recipeRepository: RecipeRepository(apiManager: APIManager()),
        swiftDataConfigurator: SwiftDataConfigurator(),
        favoritesStorageManager: FavoritesStorageManager(context: SwiftDataConfigurator().modelContext),
        favoritesRepository: FavoritesLocalRepository(storageManager: FavoritesStorageManager(context: SwiftDataConfigurator().modelContext))
    )

    init(
        credentialsManager: CredentialsManaging,
        authManager: AuthManaging,
        apiManager: APIManaging,
        recipeRepository: RecipeRepositoryProtocol,
        swiftDataConfigurator: Configurable,
        favoritesStorageManager: FavoritesStorageManaging,
        favoritesRepository: FavoritesLocalRepositoryProtocol
    ) {
        self.credentialsManager = credentialsManager
        self.authManager = authManager
        self.apiManager = apiManager
        self.recipeRepository = recipeRepository
        self.swiftDataConfigurator = swiftDataConfigurator
        self.favoritesStorageManager = favoritesStorageManager
        self.favoritesRepository = favoritesRepository
    }
}
