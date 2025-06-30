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
    
    private let repository: RecipeRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private let searchSubject = PassthroughSubject<String, Never>()
    
    init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
        setupSearch()
    }
    
    @MainActor
    func fetchRecipes() async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await repository.fetchRecipes(search: searchText)
            recipes = result
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
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
