//
//  ViewController.swift
//  IOS_Demo_UIKIT
//

import UIKit

class ViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnFloating: UIButton!
    
    //Constants
    let kHeaderTableViewCell = "HeaderTableViewCell"
    let kListItemTableViewCell = "ListItemTableViewCell"
    let viewModel = ViewControllerViewModel()

    //Variables
    var isSearching: Bool = false
    lazy var searchBar:UISearchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // load data from view model
        self.viewModel.loadData()
        self.setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpUI() {
        self.hideKeyboardWhenTappedAround()
        
        //SearchBar View
        self.searchBar.searchBarStyle = UISearchBar.Style.default
        self.searchBar.placeholder = " Search"
        self.searchBar.sizeToFit()
        self.searchBar.searchTextField.backgroundColor = .systemGray3
        self.searchBar.isTranslucent = false
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .default
        
        //Items Table View
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.sectionHeaderHeight = 1
        self.tblView.tableFooterView = UIView()
        self.tblView.keyboardDismissMode = .onDrag
        self.tblView.register(UINib(nibName: kHeaderTableViewCell, bundle: nil), forCellReuseIdentifier: kHeaderTableViewCell)
        self.tblView.register(UINib(nibName: kListItemTableViewCell, bundle: nil), forCellReuseIdentifier: kListItemTableViewCell)
        self.tblView.reloadData()
        
        self.navigationItem.title = self.viewModel.selectedCategory?.uppercased()
        
        self.btnFloating.layer.cornerRadius = 30
        self.btnFloating.layer.shadowColor = UIColor.black.cgColor
        self.btnFloating.layer.shadowOpacity = 0.2
        self.btnFloating.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.btnFloating.layer.shadowRadius = 10
        self.btnFloating.layer.masksToBounds = false
    }
    
    func updateFilteredItems(_ category: String?, _ searchText: String) {
        guard let category = category else { return }
        self.navigationItem.title = category.uppercased()
        self.viewModel.filterItems(category, searchText)
        self.tblView.reloadData()
    }
}

extension ViewController {
    @IBAction func action_BtnFloatingClicked(_ sender: UIButton) {
        self.showCustomActionSheet("Statistics", self.viewModel.getStatistics())
    }
}
