import Combine
import Foundation
import DogAPI

class BreedDetailViewModel: ObservableObject, BreedDisplayProviding {
    @Published var imageUrls: [URL]
    let breed: DogBreed
    
    private var api: DogAPIProviding
    
    init(breed: DogBreed, api: DogAPIProviding = DogAPI()) {
        self.breed = breed
        self.api = api
        imageUrls = []
    }
    
    func fetch() async throws {
        do {
            imageUrls = try await api.fetchImages(from: breed, count: 10)
        } catch {
            imageUrls = []
        }

    }
}
