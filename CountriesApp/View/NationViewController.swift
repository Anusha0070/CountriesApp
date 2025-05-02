//
//  NationViewController.swift
//  CountriesApp
//
//  Created by Anusha Raju on 5/02/25.
//

import UIKit

class NationViewController: UIViewController {
    
    private let viewModel: NationListViewModel
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)

    init(viewModel: NationListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NATIONS"
        view.backgroundColor = .systemBackground
        setupSearchController()
        setupTableView()
        dataBind()
        fetchData()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by Name or Capital"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupTableView() {
        tableView.register(NationCell.self, forCellReuseIdentifier: NationCell.reuseID)
        tableView.dataSource = self

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func dataBind() {
        
        viewModel.completionHandler = { [weak self] error in
            if let errorMessage = error {
                print(errorMessage)
            } else {
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func fetchData() {
        Task { await viewModel.loadData() }
    }
}

extension NationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNationsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NationCell.reuseID, for: indexPath) as? NationCell else {
            return UITableViewCell()
        }
        let nation = viewModel.getNationDetails(index: indexPath.row)
        cell.configure(with: nation)
        return cell
    }
}

extension NationViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.search(for: searchController.searchBar.text ?? "")
    }
}

