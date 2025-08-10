import SwiftUI
import DogAPI

var imageCache: [String: Image] = [:]

struct BreedDetailView: View {
    @ObservedObject var vm: BreedDetailViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let calculatedWidth = geometry.size.width
            ScrollView {
                heroView
                contentView(calculatedWidth)
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
    
    private var heroView: some View {
        VStack( spacing: 20) {
            if let image = imageCache[vm.breed.name] {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .shadow(radius: 10)
            }
            
            Text(vm.breed.name.capitalized)
                .font(.title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.bottom, 20)
    }

    private func contentView(_ calculatedWidth: CGFloat, spacing: CGFloat = 4) -> some View {
        VStack(spacing: spacing) {
            ForEach(Array(vm.imageChunks.enumerated()), id: \.0) { (rowIdx, row) in
                if row.count == 2 {
                    HStack(spacing: spacing) {
                        ForEach(row, id: \.self) { url in
                            breedImage(url: url, width: (calculatedWidth - spacing) / 2, height: (calculatedWidth - spacing) / 2)
                        }
                    }
                } else if let url = row.first {
                    breedImage(url: url, width: calculatedWidth, height: calculatedWidth)
                }
            }
        }
    }
    
    private func breedImage(url: URL, width: CGFloat, height: CGFloat) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
            case .failure:
                Color.gray
                    .frame(width: width, height: height)
            @unknown default:
                Color.gray
                    .frame(width: width, height: height)
            }
        }
    }
}
