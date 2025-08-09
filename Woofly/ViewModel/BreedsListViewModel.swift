import Combine
import Foundation
import DogAPI

class BreedsListViewModel: ObservableObject {
    
    @Published var vms: [BreedItemViewModel] = []
    @Published var isLoading: Bool = false

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
    
    var title: String { "Woofly" }
    
}
