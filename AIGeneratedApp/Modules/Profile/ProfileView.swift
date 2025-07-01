import SwiftUI

struct ProfileView: View {
    @State var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            // Profile Icon
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.accentColor)
                .padding(.top, 32)
            // Email Card
            if let email = viewModel.email {
                VStack(spacing: 8) {
                    Text(Strings.profileEmailLabel)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(email)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground).opacity(0.7))
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                )
                .padding(.horizontal)
            } else {
                Text(Strings.profileNoEmail)
                    .foregroundColor(.secondary)
            }
            // Logout Button
            Button(action: {
                viewModel.logout()
            }) {
                HStack {
                    Image(systemName: "arrow.backward.circle.fill")
                    Text(Strings.profileLogoutButton)
                        .fontWeight(.semibold)
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(color: .red.opacity(0.15), radius: 8, x: 0, y: 4)
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(credentialsManager: CredentialsManager(), authManager: AuthManager(credentialsManager: CredentialsManager()), onLogout: {}))
}
