import SwiftUI

struct RecipeListView: View {
    @State var viewModel: RecipeListViewModel
    var onSelectRecipe: ((String) -> Void)? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                searchField
                contentView
            }
            .navigationTitle(Strings.recipeListTitle)
            .task {
                guard viewModel.recipes.isEmpty else { return }
                await viewModel.fetchRecipes()
            }
            .onAppear {
                viewModel.reloadFavorites()
            }
        }
    }
    
    private var searchField: some View {
        TextField(Strings.recipeListSearchPlaceholder, text: $viewModel.searchText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading {
            loadingView
        } else if let error = viewModel.errorMessage {
            errorView(error)
        } else {
            recipeList
        }
    }
    
    private var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func errorView(_ error: String) -> some View {
        Text(error)
            .foregroundColor(.red)
            .padding()
    }
    
    private var recipeList: some View {
        List(viewModel.recipes) { recipe in
            HStack {
                Button(action: {
                    onSelectRecipe?(recipe.id)
                }) {
                    RecipeCell(recipe: recipe)
                }
                Spacer()
                Button(action: {
                    viewModel.toggleFavorite(recipe)
                }) {
                    Image(systemName: viewModel.isFavorite(recipe.id) ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.isFavorite(recipe.id) ? .red : .gray)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    RecipeListView(viewModel: RecipeListViewModel(repository: RecipeRepository(apiManager: APIManager()), favoritesRepository: FavoritesLocalRepository(storageManager: FavoritesStorageManager(context: SwiftDataConfigurator().modelContext))))
} 
