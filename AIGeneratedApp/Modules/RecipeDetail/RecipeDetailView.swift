import SwiftUI

struct RecipeDetailView: View {
    @State var viewModel: RecipeDetailViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                loadingView
            } else if let error = viewModel.errorMessage {
                errorView(error)
            } else if let recipe = viewModel.recipe {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        headerView(recipe)
                        metaView(recipe)
                        linksView(recipe)
                        ingredientsView(recipe)
                        instructionsView(recipe)
                    }
                    .padding()
                }
            } else {
                Text(Strings.recipeDetailNoDetails)
                    .foregroundColor(.secondary)
            }
        }
        .task {
            guard viewModel.recipe == nil else { return }
            await viewModel.fetchRecipeDetail()
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
    
    private func headerView(_ recipe: RecipeDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if let urlString = recipe.thumbnail, let url = URL(string: urlString) {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    Button(action: {
                        viewModel.toggleFavorite()
                    }) {
                        Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.isFavorite ? .red : .gray)
                            .font(.title2)
                            .padding(12)
                            .background(Color(.systemBackground).opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .padding(12)
                }
            }
            Text(recipe.name)
                .font(.title)
                .fontWeight(.bold)
        }
    }
    
    private func metaView(_ recipe: RecipeDetail) -> some View {
        HStack(spacing: 12) {
            if let category = recipe.category, !category.isEmpty {
                Label(category, systemImage: "tag")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let area = recipe.area, !area.isEmpty {
                Label(area, systemImage: "globe")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let tags = recipe.tags, !tags.isEmpty {
                Text("\(Strings.recipeDetailTags): \(tags)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private func linksView(_ recipe: RecipeDetail) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            if let youtube = recipe.youtube, let url = URL(string: youtube) {
                Link(Strings.recipeDetailYoutube, destination: url)
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            if let source = recipe.source, let url = URL(string: source) {
                Link(Strings.recipeDetailSource, destination: url)
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
        }
    }
    
    private func ingredientsView(_ recipe: RecipeDetail) -> some View {
        Group {
            if !recipe.ingredients.isEmpty {
                Text(Strings.ingredientSection)
                    .font(.headline)
                    .padding(.top)
                ForEach(Array(zip(recipe.ingredients.indices, zip(recipe.ingredients, recipe.measures))), id: \.0) { _, pair in
                    let (ingredient, measure) = pair
                    HStack {
                        Text(ingredient)
                        Spacer()
                        Text(measure)
                            .foregroundColor(.secondary)
                    }
                    .font(.subheadline)
                }
            }
        }
    }
    
    private func instructionsView(_ recipe: RecipeDetail) -> some View {
        Group {
            if let instructions = recipe.instructions, !instructions.isEmpty {
                Text(Strings.instructionsSection)
                    .font(.headline)
                    .padding(.top)
                Text(instructions)
                    .font(.body)
            }
        }
    }
}

#Preview {
    RecipeDetailView(viewModel: RecipeDetailViewModel(repository: RecipeRepository(apiManager: APIManager()), favoritesRepository: FavoritesLocalRepository(storageManager: FavoritesStorageManager(context: SwiftDataConfigurator().modelContext)), recipeId: "53086"))
}
