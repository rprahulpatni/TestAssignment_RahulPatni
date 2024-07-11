//
//  ContentView.swift
//  IOS_Demo_SwiftUI
//

import SwiftUI

struct ContentView: View {
    // Handle tab view apperance to show
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.systemBlue
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
        UITableView.appearance().sectionHeaderHeight = 0
        UITableView.appearance().sectionFooterHeight = 0
        UITableView.appearance().sectionHeaderTopPadding = 0
    }
    
    @StateObject private var viewModel = ItemsViewModel()
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showActionSheet: Bool = false
    
    var body: some View {
        // Navigation stack for handelling navigation
        NavigationStack{
            VStack{
                ScrollView{
                    // Carousal View
                    CarousalView()
                    // Search View with Item Listing
                    SearchViewWithItemListing()
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 10)
            }
            .navigationBarTitle(self.viewModel.selectedCategory.uppercased(), displayMode: .inline)
            // Tap gesture to handle hide keybaord on click of scroll view
            .gesture(TapGesture().onEnded {
                hideKeyboard()
                withAnimation {
                    self.isSearching = false
                }
                self.searchText = ""
                self.viewModel.filterItems(self.viewModel.selectedCategory, "")
            })
        }
        .onAppear{
            // Load data from view model
            self.viewModel.loadData()
        }
        .overlay(
            // Floating Button
            FloatingButton()
        )
    }
    
    // Carousal View
    @ViewBuilder
    func CarousalView() -> some View {
        if !isSearching {
            CarouselGridView(viewModel: self.viewModel, selectedCategoryIndex: self.$viewModel.selectedCategory)
                .onChange(of: self.viewModel.selectedCategory, {
                    self.viewModel.filterItems(self.viewModel.selectedCategory, "")
                })
                .padding(.bottom, -25)
        }
    }
    
    // Search View with Item Listing
    @ViewBuilder
    func SearchViewWithItemListing() -> some View {
        // LazyVSatck to handle search and item list
        LazyVStack(pinnedViews: .sectionHeaders){
            // Section for handlling search bar stuck on top view
            Section(content: {
                // Filtered Item List
                ForEach(self.viewModel.filteredItems) { items in
                    // Items Cell
                    ListCellView(locationData: items)
                }
            }, header: {
                // Search View
                SearchView(text: $searchText, isSearching: $isSearching)
                    .background(.white)
                    .onChange(of: self.searchText, {
                        // Filter Items data based on search text
                        self.viewModel.filterItems(self.viewModel.selectedCategory, self.searchText)
                    })
            })
        }
    }
    
    // Floating Button
    @ViewBuilder
    func FloatingButton() -> some View {
        VStack{
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showActionSheet.toggle()
                }) {
                    Image(systemName: "circle.grid.3x3.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .frame(width: 40, height: 40)
                .padding()
                .background(Color.teal)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 10)
                .padding()
                .sheet(isPresented: $showActionSheet, content: {
                    CustomActionSheetView(isPresented: $showActionSheet, title: "Statistics", message: self.viewModel.getStatistics())
                        .transition(.move(edge: .bottom))
                        .presentationBackground(.clear)
                        .presentationDragIndicator(.hidden)
                        .presentationDetents([.height(250)])
                })
            }
        }
    }
    
    // Func to handle hide keyboard on outside click
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}
