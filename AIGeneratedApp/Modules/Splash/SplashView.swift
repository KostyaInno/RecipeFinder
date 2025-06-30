import SwiftUI

struct SplashView: View {
    let onFinish: () -> Void
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            VStack(spacing: 24) {
                Image(systemName: "fork.knife.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.accentColor)
                Text(Strings.splashTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
        .onAppear {
            let delay = Double.random(in: 1...3)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                onFinish()
            }
        }
    }
}

#Preview {
    SplashView(onFinish: {})
} 