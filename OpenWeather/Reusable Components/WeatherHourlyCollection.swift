//
//  DetailTableViewCell.swift
//  OpenWeather
//
//  Created by Carlos on 26/5/23.
//

import UIKit

class WeatherHourlyCollection: UITableViewCell, UICollectionViewDataSource {

    private let categoryLabel = UILabel()
    private var collectionView: UICollectionView?

    let collectionCellWidthSize = 120
    let collectionCellHeightSize = 180
    let collectionCellMinimumLineSpacing: CGFloat = 20
    let collectionMinimumInteritemSpacing: CGFloat = 5

    var hourlyData = [WeatherHourly]()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureOutlets()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureOutlets() {
        categoryLabel.textColor = .black
        categoryLabel.text = "weatherHourly".localized
        categoryLabel.font = UIFont.systemFont(ofSize: 14)
        let backgroundView = UIView()
        contentView.backgroundColor = .clear
        collectionView?.backgroundColor = .clear
        backgroundView.backgroundColor = .clear
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: collectionCellWidthSize, height: collectionCellHeightSize)
        flowLayout.minimumLineSpacing = collectionCellMinimumLineSpacing
        flowLayout.minimumInteritemSpacing = collectionMinimumInteritemSpacing
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 220), collectionViewLayout: flowLayout)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = .clear

        collectionView?.dataSource = self
        collectionView?.delegate = self

        collectionView?.register(WeatherHourlyCell.self, forCellWithReuseIdentifier: "WeatherHourlyCell")

        contentView.addSubview(categoryLabel)
        contentView.addSubview(collectionView ?? UILabel())

        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

}
extension WeatherHourlyCollection: UICollectionViewDelegate {

    func updateCellWith(hourlyWeather: [WeatherHourly]) {
        hourlyData = hourlyWeather
        hourlyData.removeFirst()
        collectionView?.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherHourlyCell", for: indexPath) as? WeatherHourlyCell {
            cell.updateCell(withModel: hourlyData[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension WeatherHourlyCollection: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionMinimumInteritemSpacing, bottom: 0, right: collectionMinimumInteritemSpacing)
    }
}
