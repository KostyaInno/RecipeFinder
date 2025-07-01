import SwiftUI

struct RecipeCell: View {
    let recipe: Recipe
    var body: some View {
        HStack(spacing: 16) {
            if let urlString = recipe.thumbnail, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Color.gray.opacity(0.2)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            Text(recipe.name)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
