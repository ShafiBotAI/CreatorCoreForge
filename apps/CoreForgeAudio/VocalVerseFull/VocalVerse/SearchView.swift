#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Search and filter interface for the library.
struct SearchView: View {
    @Binding var query: String
    @Binding var sort: String
    @Binding var filters: Set<String>

    private let sorts = ["Title", "Last Played", "Duration"]
    private let filterOptions = ["Downloaded", "NSFW", "Favorites", "Incomplete"]

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Search", text: $query)
                .textFieldStyle(.roundedBorder)
            Picker("Sort", selection: $sort) {
                ForEach(sorts, id: \.self) { Text($0) }
            }
            .pickerStyle(.segmented)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(filterOptions, id: \.self) { option in
                        let isSelected = filters.contains(option)
                        Text(option)
                            .padding(8)
                            .background(isSelected ? AppTheme.primaryGradient : Color.secondary.opacity(0.2))
                            .cornerRadius(8)
                            .onTapGesture {
                                if isSelected { filters.remove(option) } else { filters.insert(option) }
                            }
                    }
                }
            }
        }
        .padding()
    }
}
#endif
