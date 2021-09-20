//
//  ListTableViewController.swift
//  WeatherApp
//
//  Created by beshssg on 19.09.2021.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    // MARK: - UIProperties:
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(plusButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        return search
    }()
    
    private lazy var cityFilter = [WeatherModel]()
    private lazy var cityEmpty = WeatherModel()
    private lazy var cityWeather = [WeatherModel]()
    private lazy var cityNames = ["Актау", "Алматы", "Нур-Султан", "Актобе", "Атырау", "Павлодар", "Дагестан", "Москва", "Питер", "Сочи"]
    
    private var isSearchBar: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltirling: Bool {
        return searchController.isActive && !isSearchBar
    }
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addCity()
        emptyCity()
        register()
        navigation()
        searchBar()
    }
    
    // MARK: - Methods:
    private func addCity() {
        getCity(city: cityNames) { [self] (index, weather) in
            cityWeather[Int(index)] = weather
            cityWeather[Int(index)].name = cityNames[index]
            
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    private func emptyCity() {
        if cityWeather.isEmpty {
            cityWeather = Array(repeating: cityEmpty, count: cityNames.count)
        }
    }
    
    private func register() {
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: String(describing: ListTableViewCell.self))
    }
    
    private func searchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        definesPresentationContext = true
    }
        
    // MARK: - NavgitaionBar:
    private func navigation() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .blue
        title = "Weather"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Add new city button:
    @objc func plusButton() {
        alertPlusCity(name: "Город", placeholder: "Введите название города") { [weak self] city in
            guard let alertCity = self else {
                return
            }
            alertCity.cityNames.append(city)
            alertCity.cityWeather.append(alertCity.cityEmpty)
            alertCity.addCity()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltirling {
            return cityFilter.count
        }
        return cityWeather.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListTableViewCell.self), for: indexPath) as! ListTableViewCell
        
        cell.backgroundColor = .white
        
        var weather = WeatherModel()
        
        if isFiltirling {
            weather = cityFilter[indexPath.row]
        } else {
            weather = cityWeather[indexPath.row]
        }
        
        cell.labelsConfigure(weather: weather)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Удалить") { [self] (_, _, complition) in
            let editing = cityNames[indexPath.row]
            
            if let index = cityNames.firstIndex(of: editing) {
                if isFiltirling {
                    cityFilter.remove(at: index)
                } else {
                    cityWeather.remove(at: index)
                }
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltirling {
            let controller = DetailViewController()
            controller.configureData(model: cityFilter[indexPath.row])
            present(controller, animated: true)
        } else {
            let controller = DetailViewController()
            controller.configureData(model: cityWeather[indexPath.row])
            present(controller, animated: true)
        }
    }
}

     // MARK: = Extension with searchBar:
extension ListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filters(search: (searchController.searchBar.text!))
    }
    
    private func filters(search: String) {
        cityFilter = cityWeather.filter {
            $0.name.contains(search)
        }
        tableView.reloadData()
    }
}
