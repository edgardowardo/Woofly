import Testing
import DogAPI
@testable import Woofly
import Foundation
internal import SwiftUI

@Suite("NavigationRouter Tests")
struct NavigationRouterTests {
    @Test("goToBreedDetail appends the correct route")
    func testGoToBreedDetailAppendsRoute() async throws {
        let router = await NavigationRouter()
        let breed = DogBreed(name: "beagle")
        await router.goToBreedDetail(breed)
        #expect(router.path.count == 1)
    }

    @Test("pop removes the last route")
    func testPopRemovesLastRoute() async throws {
        let router = await NavigationRouter()
        let breed = DogBreed(name: "beagle")
        await router.goToBreedDetail(breed)
        await router.pop()
        #expect(router.path.count == 0)
    }
    
    @Test("clear removes all routes")
    func testClearRemovesAllRoutes() async throws {
        let router = await NavigationRouter()
        let breed1 = DogBreed(name: "beagle")
        let breed2 = DogBreed(name: "boxer")
        await router.goToBreedDetail(breed1)
        await router.goToBreedDetail(breed2)
        await router.clear()
        #expect(router.path.count == 0)
    }
}
