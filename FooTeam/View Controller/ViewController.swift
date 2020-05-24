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
    
    let listAllPlayer = Player.getPlayer()
    var networkWeatherManager = NetworkWeatherManager()
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempCloudLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onCompletionWeather()
        networkWeatherManager.fetchCurrentWeather()
    }
    
    // MARK: - API parse
    private func onCompletionWeather() {
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
    }
    
    private func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.tempCloudLabel.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
}

// MARK: - Collection View
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listAllPlayer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CellViewController
        
        cell.imageCell.image = UIImage(named: listAllPlayer[indexPath.row].imageStatic!)
        cell.labelCell.text = listAllPlayer[indexPath.row].name
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.size.height / 2
        cell.imageCell.clipsToBounds = true
        
        return cell
    }
}
