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
    
    @IBOutlet var nameTemOne: [UILabel]!
    @IBOutlet var nameTemTwo: [UILabel]!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempCloudLabel: UIImageView!
    
    @IBOutlet var reserve: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModelOnlyNameTeam.shared.getTeamOne(players: Team.shared.reserve,
                                            name: reserve)
        
        ModelOnlyNameTeam.shared.getTeamOne(players: Team.shared.teamOne,
                                            name: nameTemOne)
        
        ModelOnlyNameTeam.shared.getTeamOne(players: Team.shared.teamTwo,
                                            name: nameTemTwo)
        
        TimeFoot.shared.timeFoot(timeLabel: timeLabel)
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
        return Team.shared.teamOne.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CellViewController
        
        cell.imageCell.image = UIImage(named: Team.shared.teamOne[indexPath.row].imageStatic!)
        cell.labelCell.text = Team.shared.teamOne[indexPath.row].name
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.size.height / 2
        cell.imageCell.clipsToBounds = true
        
        return cell
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Team.shared.teamTwo.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNewPlayer", for: indexPath) as! NewplayerTableViewCell
        let player = Team.shared.teamTwo[indexPath.row]
        
        cell.namePlayers.text = player.name
        cell.imagePlayers.image = UIImage(named: player.imageStatic!)
        
        cell.imagePlayers.layer.cornerRadius = cell.imagePlayers.frame.width / 2

        return cell
    }
}
