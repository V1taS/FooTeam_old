//
//  ViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ViewController: UIViewController {
    
    var networkWeatherManager = NetworkWeatherManager()

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempCloudLabel: UIImageView!
    
    
    let listAllPlayer = Player.getPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
        networkWeatherManager.fetchCurrentWeather()
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listAllPlayer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CellViewController
        
        // Configure the cell
        cell.imageCell.image = UIImage(named: listAllPlayer[indexPath.row].imageStatic!)
        
        cell.labelCell.text = listAllPlayer[indexPath.row].name
        
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.size.height / 2
        // Обрезали по краям
        cell.imageCell.clipsToBounds = true
        
        return cell
    }
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
//            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
//            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            self.tempCloudLabel.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
    
}
