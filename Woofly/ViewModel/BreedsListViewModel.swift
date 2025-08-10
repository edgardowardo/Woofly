import Combine
import Foundation
import DogAPI

class BreedsListViewModel: ObservableObject {
    
    @Published var vms: [BreedItemViewModel] = []
    @Published var isLoading: Bool = false
    @Published var refreshError: Error?

    private var detailVms: [String: BreedDetailViewModel] = [:]
    private var api: DogAPIProviding
    
    init(api: DogAPIProviding = DogAPI()) {
        self.api = api
    }
    
    func fetch() async {
        isLoading = true
        do {
            vms = try await api.fetchBreeds().map { .init(breed: $0) }
            isLoading = false
        } catch {
            vms = []
            isLoading = false
            refreshError = error
        }
    }

    func breedDetailViewModelFor(_ breed: DogBreed) -> BreedDetailViewModel {
        if let existing = detailVms[breed.name] {
            return existing
        } else {
            let newVM = BreedDetailViewModel(breed: breed)
            detailVms[breed.name] = newVM
            return newVM
        }
    }

    var title: String { "Woofly" }
    
}
