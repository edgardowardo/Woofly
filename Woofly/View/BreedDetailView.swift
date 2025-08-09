import SwiftUI
import DogAPI

var imageCache: [String: Image] = [:]

struct BreedDetailView: View {
    @ObservedObject var vm: BreedDetailViewModel
    
    var body: some View {
        imageCache[vm.breed.name]!
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            .shadow(radius: 10)
    }
}

