//
//  ViewController.swift
//  RestCountriesApp
//
//  Created by maris.rozenstoks on 17/11/2023.
//

import UIKit

class ViewController: UITableViewController {
    
    private let cellID = "cell"
    private let countryAllUrl = "https://restcountries.com/v3.1/all"
    private var countries: [Country] = []
    private var filteredCountries: [Country] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
        setupSearchController()
       
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
               tableView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
            if gestureRecognizer.state == .began {
                let touchPoint = gestureRecognizer.location(in: tableView)
                
                if let indexPath = tableView.indexPathForRow(at: touchPoint),
                   let cell = tableView.cellForRow(at: indexPath) {
                    if let countryName = cell.textLabel?.text {
                        let alert = UIAlertController(title: "Country Name", message: "These are country names", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    
    private func setupView() {
        title = "Countries"
        view.backgroundColor = UIColor(red: 0.59, green: 0.96, blue: 0.42, alpha: 1.0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        // Your existing code for navigation bar setup...
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Countries"
        searchController.searchBar.backgroundColor = UIColor.white
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func fetchData() {
        NetworkManager.fetchData(url: countryAllUrl) { [weak self] countries in
            self?.countries = countries
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCountries.count
        }
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.backgroundColor = UIColor(red: 0.89, green: 0.96, blue: 0.84, alpha: 1.0)
        
        let country: Country
        if isFiltering() {
            country = filteredCountries[indexPath.row]
        } else {
            country = countries[indexPath.row]
        }
        
        cell.textLabel?.text = country.name.common
        cell.detailTextLabel?.text = country.name.official
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry: Country
        if isFiltering() {
            selectedCountry = filteredCountries[indexPath.row]
        } else {
            selectedCountry = countries[indexPath.row]
        }
        
        let countryDetailsVC = CountryDetailsViewController()
        countryDetailsVC.country = selectedCountry
        navigationController?.pushViewController(countryDetailsVC, animated: true)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        filteredCountries = countries.filter { country in
            return country.name.common?.lowercased().contains(searchText.lowercased()) ?? false ||
                   country.name.official?.lowercased().contains(searchText.lowercased()) ?? false
        }
        
        tableView.reloadData()
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
    
    private func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}




