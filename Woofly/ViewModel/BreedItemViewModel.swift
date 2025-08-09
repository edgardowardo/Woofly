import Combine
import Foundation
import DogAPI

class BreedItemViewModel: ObservableObject, Identifiable {
    let name: String
    @Published var imageUrl: URL?

    private let breed: DogBreed
    init(breed: DogBreed) {
        name = breed.name
        self.breed = breed
    }
    
    var displayName: String {
        guard let b = breed.base else { return name.capitalized }
        return b.capitalized + " " + name.capitalized
    }
    var isIndented: Bool { breed.base != nil }
}
