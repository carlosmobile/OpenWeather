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
    private let bottomLocationSheet = FooterSheetView()
    private let spinnerView = SpinnerViewController()
    let refreshControl = UIRefreshControl()
    let refreshTableSpinnerPosition: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        
        configureUI()
        configureViewModelObserver()
    }
    
    private func configureUI() {
        refreshControl.bounds.origin.y = refreshTableSpinnerPosition
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        view.setGradientBackground(colorOne: .cyan, colorTwo: .blue)
        weatherTableView.separatorStyle = .none
        weatherTableView.allowsSelection = false
        weatherTableView.backgroundColor = .clear
        weatherTableView.register(WeatherHeaderCell.self, forCellReuseIdentifier: "WeatherHeaderCell")
        weatherTableView.register(WeatherHourlyCollection.self, forCellReuseIdentifier: "WeatherHourlyCollection")
        weatherTableView.addSubview(refreshControl)
        view.addSubview(weatherTableView)
        view.addSubview(bottomLocationSheet)
        
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        bottomLocationSheet.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            weatherTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomLocationSheet.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            bottomLocationSheet.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            bottomLocationSheet.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            bottomLocationSheet.heightAnchor.constraint(equalToConstant: 200)
        ])

        bottomLocationSheet.buttonTargetAction = (self,#selector(WeatherViewController.sheetButtonAction))
    }
    
    @objc private func refresh() {
        viewModel.checkLocation()
        refreshControl.endRefreshing()
    }
    
    @objc func sheetButtonAction(sender: UIButton!) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    private func configureViewModelObserver() {
        viewModel.weatherData.bind { (_) in
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
            }
            
        }
        
        viewModel.isNecessaryToShowBottomLocationSheet.bind { value in
            guard let showBottom = value else { return }
            UIView.transition(with: self.view, duration: 0.7, options: [.transitionCrossDissolve], animations: {
                self.bottomLocationSheet.isHidden = !showBottom
            }, completion: nil)
        }
        
        viewModel.isLoadingData.bind { [weak self] value in
            guard let self = self else { return }
            guard let isLoading = value else { return }
            if isLoading {
                addChild(spinnerView)
                spinnerView.view.frame = view.frame
                view.addSubview(spinnerView.view)
                spinnerView.didMove(toParent: self)
            } else {
                spinnerView.willMove(toParent: nil)
                spinnerView.view.removeFromSuperview()
                spinnerView.removeFromParent()
            }
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
        guard let weatherData = viewModel.weatherData.value else { return cell }

        switch indexPath.row {
        case Table.WeatherHeader.rawValue:
            guard let weatherHeaderCell = tableView.dequeueReusableCell(withIdentifier: "WeatherHeaderCell") as? WeatherHeaderCell else {
                return cell
            }
            weatherHeaderCell.updateCell(withModel: weatherData)
            return weatherHeaderCell
        case Table.WeatherByHours.rawValue:
            guard let hourlyListCell = tableView.dequeueReusableCell(withIdentifier: "WeatherHourlyCollection") as? WeatherHourlyCollection else {
                return cell
            }
            hourlyListCell.backgroundColor = .clear
            hourlyListCell.updateCellWith(hourlyWeather: weatherData.hourly)
            return hourlyListCell
        default:
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case Table.WeatherHeader.rawValue:
            return 320
        case Table.WeatherByHours.rawValue:
            return 240
        default:
            return 0
        }
    }
}
