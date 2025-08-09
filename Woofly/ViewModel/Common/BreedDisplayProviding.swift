import DogAPI
import Foundation

protocol BreedDisplayProviding {
    var breed: DogBreed { get }
}

extension BreedDisplayProviding {
    var displayName: String {
        guard let b = breed.base else { return breed.name.capitalized }
        return b.capitalized + " " + breed.name.capitalized
    }
}
