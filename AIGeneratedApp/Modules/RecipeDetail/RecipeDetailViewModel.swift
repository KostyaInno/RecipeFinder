import Foundation
import Observation

@Observable
final class RecipeDetailViewModel {
    var recipe: RecipeDetail?
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let repository: RecipeRepositoryProtocol
    private let recipeId: String
    
    init(repository: RecipeRepositoryProtocol, recipeId: String) {
        self.repository = repository
        self.recipeId = recipeId
    }
    
    @MainActor
    func fetchRecipeDetail() async {
        isLoading = true
        errorMessage = nil
        do {
            recipe = try await repository.fetchRecipeDetail(id: recipeId)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
} 
