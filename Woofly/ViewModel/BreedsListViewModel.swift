import Combine
import Foundation
import DogAPI

class BreedsListViewModel: ObservableObject {
    
    @Published var vms: [BreedItemViewModel] = []
    @Published var isLoading: Bool = false

    var detailVms: [String: BreedDetailViewModel] = [:]

    private var api: DogAPIProviding
    
    init(api: DogAPIProviding = DogAPI()) {
        self.api = api
    }
    
    func fetch() async throws {
        isLoading = true
        do {
            vms = try await api.fetchBreeds().map { .init(breed: $0) }

        } catch{
            vms = []
            isLoading = false
            // TODO: throw error
        }
    }

    func breedDetailViewModelFor(_ breed: DogBreed) -> BreedDetailViewModel {
        detailVms[breed.name, default: .init(breed: breed)]
    }

    var title: String { "Woofly" }
    
}
