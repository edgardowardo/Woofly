import SwiftUI
import DogAPI
import Playgrounds

struct BreedsListView: View {
    @StateObject private var vm: BreedsListViewModel

    init() {
        self._vm = StateObject(wrappedValue: .init(api: DogAPI()))
    }
    
    var body: some View {
        NavigationView {
            List(vm.vms) { v in
                NavigationLink(destination: BreedDetailView(vm: vm.breedDetailViewModelFor(v.breed))) {
                    BreedItemView(vm: v)
                }
            }            
            .navigationTitle(vm.title)
        }
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
