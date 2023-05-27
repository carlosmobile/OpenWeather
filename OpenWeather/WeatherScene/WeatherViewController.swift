//
//  WeatherViewController.swift
//  OpenWeather
//
//  Created by Carlos on 26/5/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    var viewModel: WeatherViewModel = WeatherViewModel()
        
    private let weatherTableView = UITableView()
    private let bottomLocationSheet = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        
        configureUI()
        configureViewModelObserver()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        weatherTableView.backgroundColor = .red
                
        weatherTableView.register(WeatherHeaderCell.self, forCellReuseIdentifier: "WeatherHeaderCell")
        
        view.addSubview(weatherTableView)
        view.addSubview(bottomLocationSheet)
        
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        bottomLocationSheet.translatesAutoresizingMaskIntoConstraints = false
        
        weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        weatherTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        weatherTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        bottomLocationSheet.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bottomLocationSheet.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        bottomLocationSheet.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomLocationSheet.heightAnchor.constraint(equalToConstant: 200).isActive = true

        bottomLocationSheet.backgroundColor = .blue
    }
    
    private func configureViewModelObserver() {
        viewModel.weatherData.bind { (_) in
            print("bbb weatherModel updated")
        }
        
        viewModel.isNecessaryToShowBottomLocationSheet.bind { value in
            guard let showBottom = value else { return }
            self.bottomLocationSheet.isHidden = !showBottom
        }
    }

}

//MARK: - UITableView Configuration

enum Table: Int, CaseIterable {
  case WeatherHeader
  case WeatherByHours
}

//MARK: - UITableViewDataSource

extension WeatherViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Table.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()

        switch indexPath.section {
        case Table.WeatherHeader.rawValue:
            guard let characterListCell = tableView.dequeueReusableCell(withIdentifier: "WeatherHeaderCell") as? WeatherHeaderCell else {
                return cell
            }
            return characterListCell
        case Table.WeatherByHours.rawValue:
            return cell
        default:
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension WeatherViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("tapped")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
