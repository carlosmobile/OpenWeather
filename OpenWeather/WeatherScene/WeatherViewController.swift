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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        
        configureUI()
        configureViewModelObserver()
    }
    
    private func configureUI() {
                
        weatherTableView.register(WeatherHeaderCell.self, forCellReuseIdentifier: "WeatherHeaderCell")
        
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

        bottomLocationSheet.backgroundColor = .blue
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

        switch indexPath.section {
        case Table.WeatherHeader.rawValue:
            guard let characterListCell = tableView.dequeueReusableCell(withIdentifier: "WeatherHeaderCell") as? WeatherHeaderCell else {
                return cell
            }
            guard let weatherData = viewModel.weatherData.value else { return cell }
            characterListCell.updateCell(withModel: weatherData)
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
        return 300
    }
}
