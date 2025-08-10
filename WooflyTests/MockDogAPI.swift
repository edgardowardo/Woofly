
import DogAPI
import Foundation
import MockDogJSON

class MockDogAPI: DogAPIProviding, DogBreedsMapProviding {
    func fetchBreeds() async throws -> [DogBreed] {
        guard let data = MockDogJSON.breedsList.data(using: .utf8) else { throw DogAPIError.invalidJSON }
        let decoded = try JSONDecoder().decode(DogBreedsResponse.self, from: data)
        return MockDogAPI.map(decoded)
    }
    
    func fetchImages(from breed: DogBreed, count: Int) async throws -> [URL] {
        guard let data = MockDogJSON.houndList.data(using: .utf8) else { throw DogAPIError.invalidJSON }
        let decoded = try JSONDecoder().decode(DogImagesResponse.self, from: data)
        return decoded.message.map { URL(string: $0)! }
    }
    
    func fetchImage(from breed: DogBreed) async throws -> URL {
        guard let data = MockDogJSON.houndSingle.data(using: .utf8) else { throw DogAPIError.invalidJSON }
        let decoded = try JSONDecoder().decode(DogImageResponse.self, from: data)
        return URL(string: decoded.message.self)!
    }
}

class MockDogAPIErrors: DogAPIProviding, DogBreedsMapProviding {
    func fetchBreeds() async throws -> [DogBreed] {
        guard let data = MockDogJSON.breedsListBad.data(using: .utf8) else { throw DogAPIError.invalidJSON }
        let decoded = try JSONDecoder().decode(DogBreedsResponse.self, from: data)
        return MockDogAPI.map(decoded)
    }
    
    func fetchImages(from breed: DogBreed, count: Int) async throws -> [URL] {
        guard let data = MockDogJSON.houndListBad.data(using: .utf8) else { throw DogAPIError.invalidJSON }
        let decoded = try JSONDecoder().decode(DogImagesResponse.self, from: data)
        return decoded.message.map { URL(string: $0)! }
    }
    
    func fetchImage(from breed: DogBreed) async throws -> URL {
        guard let data = MockDogJSON.houndSingleBad.data(using: .utf8) else { throw DogAPIError.invalidJSON }
        let decoded = try JSONDecoder().decode(DogImageResponse.self, from: data)
        return URL(string: decoded.message.self)!
    }
}



//
// MARK: Private
//
private struct DogBreedsResponse: Codable {
    let message: [String: [String]]
    let status: String
}

private struct DogImageResponse: Codable {
    let message: String
    let status: String
}

private struct DogImagesResponse: Codable {
    let message: [String]
    let status: String
}

private protocol DogBreedsMapProviding {
    static func map(_ response: DogBreedsResponse) -> [DogBreed]
}

private extension DogBreedsMapProviding {
    static func map(_ response: DogBreedsResponse) -> [DogBreed] {
        let list = response.message.flatMap { main, subs in
            (subs.isEmpty ? [DogBreed(base: nil, name: main, subBreeds: nil)]
             : [DogBreed(base: nil, name: main, subBreeds: subs.map {
                subName in DogBreed(base: main, name: subName, subBreeds: nil) })] )
        }
        return list.sorted { lhs, rhs in lhs.name < rhs.name }
    }
}
