import Combine
import Foundation
import DogAPI

class BreedItemViewModel: ObservableObject, Identifiable, BreedDisplayProviding {
    @Published var imageUrl: URL?
    let breed: DogBreed
    
    init(breed: DogBreed) {
        self.breed = breed
    }
    
    var isIndented: Bool { breed.base != nil }
}
