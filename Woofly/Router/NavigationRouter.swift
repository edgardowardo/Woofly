import Combine
import SwiftUI
import DogAPI

enum AppRoute: Hashable {
    case breedDetail(breed: DogBreed)
}

class NavigationRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func pop() {
        path.removeLast()
    }
    
    func clear() {
        path.removeLast(path.count)
    }

    // Add destinations
    func goToBreedDetail(_ breed: DogBreed) {
        path.append(AppRoute.breedDetail(breed: breed))
    }

}
