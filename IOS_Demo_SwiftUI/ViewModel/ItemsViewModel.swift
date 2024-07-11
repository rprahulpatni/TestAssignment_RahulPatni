//
//  ItemsViewModel.swift
//  IOS_Demo_SwiftUI
//

import Foundation

final class ItemsViewModel: ObservableObject {
    @Published var items: [LocationData] = []
    @Published var categories: [String] = []
    @Published var categoriesData: [String: [LocationData]] = [:]
    @Published var filteredItems: [LocationData] = []
    @Published var selectedCategory: String = ""
    @Published var currentPageIndex = 0
    
    //Load data from local json
    func loadData() {
        self.items = []
        self.items = BundleDecoderFromJson.decodeLandmarkFromBundleToJson()
        self.categories = []
        self.categories = Array(Set( self.items.map { $0.category })).sorted()
        self.categoriesData = Dictionary(grouping: items, by: { $0.category })
        self.filterItems(self.categories.first!, "")
    }
    
    //Get filtered data
    func filterItems(_ selectedCategory: String, _ searchText: String) {
        self.selectedCategory = selectedCategory
        self.filteredItems = []
        let filteredData = items.filter { $0.category == selectedCategory }
        if searchText.isEmpty {
            self.filteredItems = filteredData
        } else {
            self.filteredItems = filteredData.filter{ $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    //Get Top 3 Characters to show on floating button
    func getTop3Characters() -> [(Character, Int)] {
        var charCount: [Character: Int] = [:]
        for location in self.filteredItems {
            for char in location.name.lowercased() {
                if char.isLetter {
                    charCount[char, default: 0] += 1
                }
            }
        }
        return charCount.sorted { $0.value > $1.value }.prefix(3).map { $0 }
    }
    
    func getStatistics() -> String {
        let top3Characters = self.getTop3Characters()
        return "Items on this page: \(self.filteredItems.count)\nTop 3 characters: \(top3Characters.map { "\($0.0): \($0.1)" }.joined(separator: ", "))"
    }
}
