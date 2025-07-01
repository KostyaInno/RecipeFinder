import Foundation
import Observation
import Combine

@Observable
final class RecipeListViewModel {
    var recipes: [Recipe] = []
    var searchText: String = "" {
        didSet { searchSubject.send(searchText) }
    }
    var isLoading: Bool = false
    var errorMessage: String? = nil
    private var favoriteIDs: Set<String> = []

    private let recipeRepository: RecipeRepositoryProtocol
    private let favoritesRepository: FavoritesLocalRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private let searchSubject = PassthroughSubject<String, Never>()
    
    init(recipeRepository: RecipeRepositoryProtocol, favoritesRepository: FavoritesLocalRepositoryProtocol) {
        self.recipeRepository = recipeRepository
        self.favoritesRepository = favoritesRepository
        loadFavorites()
        setupSearch()
    }
    
    @MainActor
    func fetchRecipes() async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await recipeRepository.fetchRecipes(search: searchText)
            recipes = result
            loadFavorites()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func isFavorite(_ id: String) -> Bool {
        favoriteIDs.contains(id)
    }
    
    func toggleFavorite(_ recipe: Recipe) {
        if isFavorite(recipe.id) {
            removeFavorite(recipe)
        } else {
            addFavorite(recipe)
        }
    }
    
    func reloadFavorites() {
        loadFavorites()
    }
    
    private func addFavorite(_ recipe: Recipe) {
        do {
            let favorite = RecipeMapper.toFavorite(recipe)
            try favoritesRepository.addOrUpdateFavorite(favorite)
            favoriteIDs.insert(recipe.id)
        } catch {
            // Handle error (optional: set errorMessage)
        }
    }
    
    private func removeFavorite(_ recipe: Recipe) {
        do {
            try favoritesRepository.removeFavorite(recipeId: recipe.id)
            favoriteIDs.remove(recipe.id)
        } catch {
            // Handle error (optional: set errorMessage)
        }
    }
    
    private func loadFavorites() {
        do {
            let favorites = try favoritesRepository.fetchFavorites()
            favoriteIDs = Set(favorites.map { $0.id })
        } catch {
            favoriteIDs = []
        }
    }
    
    private func setupSearch() {
        searchSubject
            .removeDuplicates()
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                Task { await self?.fetchRecipes() }
            }
            .store(in: &cancellables)
    }
}
