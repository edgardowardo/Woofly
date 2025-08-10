import Combine
import Foundation
import DogAPI

class BreedDetailViewModel: ObservableObject, BreedDisplayProviding {
    @Published var imageChunks: [[URL]]
    @Published var refreshError: Error?
    let breed: DogBreed
    
    private var api: DogAPIProviding
    
    init(breed: DogBreed, api: DogAPIProviding = DogAPI()) {
        self.breed = breed
        self.api = api
        imageChunks = []
    }
    
    func fetch() async {
        do {
            let urls = try await api.fetchImages(from: breed, count: 10)
            imageChunks = chunkImages(urls)
        } catch {
            imageChunks = []
            refreshError = error
        }
    }
    
    private func chunkImages(_ images: [URL]) -> [[URL]] {
        var result: [[URL]] = []
        var index = 0
        var toggle = true
        while index < images.count {
            let size = toggle ? 2 : 1
            let next = Array(images[index..<min(index+size, images.count)])
            result.append(next)
            index += size
            toggle.toggle()
        }
        return result
    }
}
