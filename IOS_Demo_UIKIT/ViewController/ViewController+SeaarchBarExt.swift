//
//  ViewController+SeaarchBarExt.swift
//  IOS_Demo_UIKIT
//

import Foundation
import UIKit

//==================================================
// MARK:- UISearchBarDelegate
//==================================================
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.viewModel.filterItems(self.viewModel.selectedCategory, "")
        } else {
            self.viewModel.filterItems(self.viewModel.selectedCategory, searchText)
        }
        self.tblView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isSearching = true
        self.tblView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isSearching = false
        self.tblView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        self.updateFilteredItems(self.viewModel.selectedCategory, "")
    }
}
