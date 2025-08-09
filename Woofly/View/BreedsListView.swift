import SwiftUI
import DogAPI
import Playgrounds

struct BreedsListView: View {
    @StateObject var vm: BreedsListViewModel
    private var detailVms: [String: BreedDetailViewModel] = [:]

    init() {
        self._vm = StateObject(wrappedValue: .init(api: DogAPI()))
    }
    
    var body: some View {
        NavigationView {
            List(vm.vms) { v in
                NavigationLink(destination: BreedDetailView(vm: breedDetailViewModelFor(v.breed))) {
                    BreedItemView(vm: v)
                }
            }            
            .navigationTitle(vm.title)
        }
        .task {
            await refresh()
        }
    }
    
    private func breedDetailViewModelFor(_ breed: DogBreed) -> BreedDetailViewModel {
        detailVms[breed.name, default: .init(breed: breed)]
    }
    
    private func refresh() async {
        do {
            try await vm.fetch()
        } catch {
            // modal manager show error
        }
    }
}
