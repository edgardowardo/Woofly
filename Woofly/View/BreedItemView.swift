import SwiftUI
import DogAPI
import Playgrounds

struct BreedItemView: View {
    @ObservedObject var vm: BreedItemViewModel
    
    var body: some View {
        HStack(spacing: 8) {
            AsyncImage(url: vm.imageUrl) { phase in
                switch phase {
                case .empty:
                    Image(systemName: "arrow.2.circlepath.circle")
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
                        
            Text(vm.displayName)
                .font(.body)
                .padding(.leading, vm.isIndented ? 16 : 0)
        }
    }
}

#Preview {
    BreedItemView(vm: BreedItemViewModel(breed: DogBreed(name: "boxer")))
}
