//
//  CarouselGridView.swift
//  IOS_Demo_SwiftUI
//

import SwiftUI

struct CarouselGridView: View {
    @ObservedObject var viewModel: ItemsViewModel
    @Binding var selectedCategoryIndex: String

    var body: some View {
        //TabView to handle carousal view with pagecontrol
        TabView(selection: $selectedCategoryIndex) {
            ForEach(self.viewModel.categories, id: \.self) { category in
                let data = self.viewModel.items.filter({ $0.category.lowercased() == category.lowercased() })
                CategoryCarouselView(items: data.first!)
                    .tag(category)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 245)
        .onChange(of: self.selectedCategoryIndex, {
            self.viewModel.selectedCategory = self.selectedCategoryIndex
        })
    }
}

struct CategoryCarouselView: View {
    let items: LocationData
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: items.imageUrl)) { image in
                image.resizable()
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            Spacer(minLength: 10)
        }
    }
}


#Preview {
    CarouselGridView(viewModel: ItemsViewModel(), selectedCategoryIndex: .constant(ItemsViewModel().selectedCategory))
}
