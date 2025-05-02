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
    private let searchBar = UISearchBar()

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
        setupSearchBar()
        setupTableView()
        dataBind()
        fetchData()
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "Search by name or capital"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupTableView() {
        tableView.register(NationCell.self, forCellReuseIdentifier: NationCell.reuseID)
        tableView.dataSource = self

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func dataBind() {
        
        viewModel.completionHandler = { [weak self] error in
            if error == nil {
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
            } else {
                print(error ?? "Error fetching data")
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

extension NationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(for: searchText)
    }
}

