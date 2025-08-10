import Testing
import DogAPI
@testable import Woofly
import Foundation

@Suite("Woofly ViewModel Tests")
struct WooflyViewModelTests {
    @Test("BreedItemViewModel isIndented property - non-indented breed")
    func testBreedItemViewModelIsIndentedFalse() async throws {
        let breed = DogBreed(name: "bulldog") // base is nil
        let vm = await BreedItemViewModel(breed: breed, api: MockDogAPI())
        #expect(!vm.isIndented)
    }

    @Test("BreedItemViewModel isIndented property - indented breed")
    func testBreedItemViewModelIsIndentedTrue() async throws {
        let breed = DogBreed(base: "bulldog", name: "french", subBreeds: nil)
        let vm = await BreedItemViewModel(breed: breed, api: MockDogAPI())
        #expect(vm.isIndented)
    }

    @Test("BreedsListViewModel breedDetailViewModelFor returns consistent instance")
    func testBreedsListViewModelBreedDetailViewModelFor() async throws {
        let breed = DogBreed(name: "beagle")
        let vm = await BreedsListViewModel(api: MockDogAPI())
        let detail1 = await vm.breedDetailViewModelFor(breed)
        let detail2 = await vm.breedDetailViewModelFor(breed)
        #expect(detail1 === detail2, "Should return the same instance for the same breed name")
        #expect(detail1.breed.name == "beagle")
        #expect(detail2.breed.name == "beagle")
    }

    @Test("BreedsListViewModel title property returns 'Woofly'")
    func testBreedsListViewModelTitle() async throws {
        let vm = await BreedsListViewModel(api: MockDogAPI())
        #expect(vm.title == "Woofly")
    }
    
    @Test("BreedsListViewModel fetches breeds successfully")
    func testBreedsListViewModelFetchSuccess() async throws {
        let mockAPI = MockDogAPI()
        let vm = await BreedsListViewModel(api: mockAPI)
        await vm.fetch()
        #expect(vm.vms.count == 107)
        #expect(!vm.isLoading)
        #expect(vm.refreshError == nil)
    }
    
    @Test("BreedsListViewModel handles fetch error")
    func testBreedsListViewModelFetchError() async throws {
        let mockAPI = MockDogAPIErrors()
        let vm = await BreedsListViewModel(api: mockAPI)
        await vm.fetch()
        #expect(vm.vms.isEmpty)
        #expect(!vm.isLoading)
        #expect(vm.refreshError != nil)
    }

    @Test("BreedItemViewModel fetches image URL successfully")
    func testBreedItemViewModelFetchSuccess() async throws {
        let breed = DogBreed(name: "beagle")
        let mockAPI = MockDogAPI()
        let vm = await BreedItemViewModel(breed: breed, api: mockAPI)
        await vm.fetch()
        #expect(vm.imageUrl != nil)
    }
    
    @Test("BreedItemViewModel handles fetch image error")
    func testBreedItemViewModelFetchError() async throws {
        let breed = DogBreed(name: "beagle")
        let mockAPI = MockDogAPIErrors()
        let vm = await BreedItemViewModel(breed: breed, api: mockAPI)
        await vm.fetch()
        #expect(vm.imageUrl == nil)
    }

    @Test("BreedDetailViewModel fetches and chunks images correctly")
    func testBreedDetailViewModelFetchSuccess() async throws {
        let breed = DogBreed(name: "boxer")
        let mockAPI = MockDogAPI()
        let vm = await BreedDetailViewModel(breed: breed, api: mockAPI)
        await vm.fetch()
        let totalImages = await vm.imageChunks.reduce(0) { $0 + $1.count }
        #expect(totalImages == 3)
        #expect(vm.refreshError == nil)
    }
    
    @Test("BreedDetailViewModel handles fetch images error")
    func testBreedDetailViewModelFetchError() async throws {
        let breed = DogBreed(name: "boxer")
        let mockAPI = MockDogAPIErrors()
        let vm = await BreedDetailViewModel(breed: breed, api: mockAPI)
        await vm.fetch()
        #expect(vm.imageChunks.isEmpty)
        #expect(vm.refreshError != nil)
    }
}

