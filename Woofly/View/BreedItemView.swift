import SwiftUI
import DogAPI

struct BreedItemView: View {
    @ObservedObject var vm: BreedItemViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: vm.imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "exclamationmark.circle")
                @unknown default:
                    Image(systemName: "exclamationmark.circle.fill")
                }
            }
            .frame(width: 100, height: 100)
                        
            Text(vm.displayName)
                .font(.body)
                .padding(.leading, vm.isIndented ? 16 : 0)
        }
        .onAppear {
            Task {
                await refresh()
            }
        }

    }
        
    private func refresh() async {
        do {
            try await vm.fetchImage()
        } catch {
            print("error fetching image")
        }
    }
}

#Preview {
    BreedItemView(vm: BreedItemViewModel(breed: DogBreed(name: "boxer")))
}
