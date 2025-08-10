import Combine
import Foundation
import DogAPI

class BreedItemViewModel: ObservableObject, Identifiable, BreedDisplayProviding {
    @Published var imageUrl: URL?
    let breed: DogBreed
    
    private var api: DogAPIProviding
    
    init(breed: DogBreed, api: DogAPIProviding = DogAPI()) {
        self.breed = breed
        self.api = api
    }
    
    var isIndented: Bool { breed.base != nil }
    
    func fetch() async throws {
        guard imageUrl == nil else { return }
        do {
            imageUrl = try await api.fetchImage(from: breed)
        } catch {
            imageUrl = nil
            throw error
        }
    }
}
