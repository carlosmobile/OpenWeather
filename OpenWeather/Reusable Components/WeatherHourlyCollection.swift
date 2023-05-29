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

    private let categoryLabelHeight: CGFloat = 20
    private let categoryLabelFontSize: CGFloat = 14
    private let categoryLabelLeadingOffset: CGFloat = 14
    private let collectionTopOffset = 20
    private let collectionViewHeight = 200
    private let collectionCellWidth = 120
    private let collectionCellHeight = 180
    private let collectionCellMinimumLineSpacing: CGFloat = 20
    private let collectionMinimumInteritemSpacing: CGFloat = 5

    var hourlyData = [WeatherHourly]()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        categoryLabel.textColor = .black
        categoryLabel.text = "weatherHourly".localized
        categoryLabel.font = UIFont.systemFont(ofSize: categoryLabelFontSize)
        
        let backgroundView = UIView()
        contentView.backgroundColor = .clear
        collectionView?.backgroundColor = .clear
        backgroundView.backgroundColor = .clear
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellHeight)
        flowLayout.minimumLineSpacing = collectionCellMinimumLineSpacing
        flowLayout.minimumInteritemSpacing = collectionMinimumInteritemSpacing
        
        collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: collectionTopOffset,
                                                        width: Int(UIScreen.main.bounds.width),
                                                        height: collectionViewHeight),
                                          collectionViewLayout: flowLayout)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = .clear
        collectionView?.accessibilityIdentifier = "hourlyCollection"
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(WeatherHourlyCell.self, forCellWithReuseIdentifier: "WeatherHourlyCell")

        contentView.addSubview(categoryLabel)
        contentView.addSubview(collectionView ?? UILabel())

        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: categoryLabelLeadingOffset),
            categoryLabel.heightAnchor.constraint(equalToConstant: categoryLabelHeight),
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
        let cellIdentifier = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherHourlyCell", for: indexPath)
        if let cell = cellIdentifier as? WeatherHourlyCell {
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
