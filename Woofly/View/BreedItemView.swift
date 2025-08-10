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
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        .shadow(radius: 10)
                        .onAppear {
                            imageCache[vm.breed.name] = image
                        }
                case .failure:
                    Image(systemName: "exclamationmark.circle")
                @unknown default:
                    Image(systemName: "exclamationmark.circle.fill")
                }
            }
            .frame(width: 60, height: 60)
                        
            Text(vm.displayName)
                .font(.body)
                .padding(.leading, vm.isIndented ? 16 : 0)
        }
        .task {
            await refresh()
        }
    }
        
    private func refresh() async {
        do {
            try await vm.fetch()
        } catch {
            print("error fetching image")
        }
    }
}

#Preview {
    BreedItemView(vm: BreedItemViewModel(breed: DogBreed(name: "boxer")))
}
