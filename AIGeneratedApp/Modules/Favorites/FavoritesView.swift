import SwiftUI

struct FavoritesView: View {
    @State var viewModel: FavoritesListViewModel
    @State private var selectedRecipe: Recipe?

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.favorites) { favorite in
                    Button(action: {
                        selectedRecipe = favorite
                    }) {
                        RecipeCell(recipe: favorite)
                    }
                }
                .onDelete(perform: viewModel.deleteFavorite)
            }
            .navigationTitle(Strings.favoritesTabTitle)
            .onAppear {
                viewModel.loadFavorites()
            }
            .onChange(of: selectedRecipe) { _, newValue in
                guard newValue == nil else { return }
                viewModel.loadFavorites()
            }
            .sheet(item: $selectedRecipe) { recipe in
                RecipeDetailView(
                    viewModel: RecipeDetailViewModel(
                        repository: viewModel.recipeRepository,
                        favoritesRepository: viewModel.favoritesRepository,
                        recipeId: recipe.id
                    )
                )
            }
        }
    }
} 
