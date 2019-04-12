//
//  MainViewController.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/8/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Stored Properties -
    
    weak var coordinator: MainCoordinator?
    
    /// ViewModel
    lazy var viewModel : ViewModel? = {
        return ViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        viewConfiguration()
        configureTableView()
    }
    
    // MARK - View Configuration -
    
    func viewConfiguration() {
        searchBar.delegate = self
        searchBar.tintColor = UIColor.lightGray
        searchBar.addDoneButtonOnKeyboard()
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.lightGray
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = MainTableViewCell.rowHeight
        tableView.register(UINib(nibName: MainTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
    }
    
    // MARK: - View Model Initial Configuration -
    
    func initViewModel() {
        /// Assign delegate implemented in [this section](x-source-tag://ViewModel)
        viewModel?.delegate = self
        
        viewModel?.fetchGnomes()
    }

}

// MARK: - TableView Data Source & Delegate -

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.gnomes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier) as? MainTableViewCell,
            let gnomes = viewModel?.gnomes else {
            return UITableViewCell()
        }
        cell.gnome = gnomes[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let gnomeSelected = viewModel?.gnomes?[indexPath.row] {
            coordinator?.goToDetail(with: gnomeSelected)
        }
    }
}

// MARK: - View Model Delegate -

extension MainViewController: ViewModelDelegate {
    func reloadUI() {
        tableView.reloadData()
    }
}

// MARK - Search Bar Delegate -

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.fetchGnomes(with: searchBar.text ?? "")
    }
}
