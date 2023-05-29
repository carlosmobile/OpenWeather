//
//  WeatherViewController.swift
//  OpenWeather
//
//  Created by Carlos on 26/5/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    private let refreshTableSpinnerPosition: CGFloat = 20
    private let locationSheetHeightView: CGFloat = 200
    private let weatherHeaderCellHeight: CGFloat = 320
    private let weatherByHoursCellHeight: CGFloat = 240
    
    var viewModel: WeatherViewModel = WeatherViewModel()
        
    private let weatherTableView = UITableView()
    private let bottomLocationSheet = FooterSheetView()
    private let spinnerView = SpinnerViewController()
    private let refreshControl = UIRefreshControl()
    
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
        
        view.setGradientBackground(firstColor: .cyan, secondColor: .blue)
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
            bottomLocationSheet.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomLocationSheet.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomLocationSheet.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomLocationSheet.heightAnchor.constraint(equalToConstant: locationSheetHeightView)
        ])

        bottomLocationSheet.buttonTargetAction = (self,#selector(WeatherViewController.sheetButtonAction))
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
                self.addLoaderSpinner()
            } else {
                self.removeLoaderSpinner()
            }
        }
    }
    
    private func addLoaderSpinner() {
        addChild(spinnerView)
        spinnerView.view.frame = view.frame
        view.addSubview(spinnerView.view)
        spinnerView.didMove(toParent: self)
    }
    
    private func removeLoaderSpinner() {
        spinnerView.willMove(toParent: nil)
        spinnerView.view.removeFromSuperview()
        spinnerView.removeFromParent()
    }
    
    @objc private func refresh() {
        viewModel.checkLocation()
        refreshControl.endRefreshing()
    }
    
    @objc func sheetButtonAction(sender: UIButton!) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
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
            let cellIdentifier = tableView.dequeueReusableCell(withIdentifier: "WeatherHeaderCell")
            guard let weatherHeaderCell = cellIdentifier as? WeatherHeaderCell else {
                return cell
            }
            weatherHeaderCell.updateCell(withModel: weatherData)
            return weatherHeaderCell
        case Table.WeatherByHours.rawValue:
            let cellIdentifier = tableView.dequeueReusableCell(withIdentifier: "WeatherHourlyCollection")
            guard let hourlyListCell = cellIdentifier as? WeatherHourlyCollection else {
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
            return weatherHeaderCellHeight
        case Table.WeatherByHours.rawValue:
            return weatherByHoursCellHeight
        default:
            return 0
        }
    }
}
