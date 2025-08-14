import SwiftUI
import DogAPI
import Playgrounds

struct BreedsListView: View {
    @StateObject  var vm : BreedsListViewModel
    @StateObject var router: NavigationRouter

    init() {
        self._vm = StateObject(wrappedValue: .init(api: DogAPI()))
        self._router = StateObject(wrappedValue: .init())
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            List(vm.vms) { v in
                Button {
                    router.goToBreedDetail(v.breed)
                } label: {
                    BreedItemView(vm: v)
                }
            }
            .foregroundStyle(.primary)
            .navigationTitle(vm.title)
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .breedDetail(let breed):
                    BreedDetailView(vm: vm.breedDetailViewModelFor(breed))
                }
            }
        }
        .environmentObject(router)
        .task {
            await vm.fetch()
        }
        .alert("Refresh Failed", isPresented: .constant(vm.refreshError != nil), presenting: vm.refreshError) { error in
            Button("OK") { vm.refreshError = nil }
        } message: { error in
            Text(error.localizedDescription)
        }
    }
}

#Preview {
    BreedsListView()
}
