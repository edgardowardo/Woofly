import Combine
import Foundation
import DogAPI

class BreedDetailViewModel: ObservableObject, BreedDisplayProviding {
    @Published var imageUrls: [URL]
    let breed: DogBreed
    
    init(breed: DogBreed) {
        self.breed = breed
        imageUrls = []
    }
}
