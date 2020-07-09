//
//  MainViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet var tableViewNewPlayers: UITableView!
    @IBOutlet weak var collectionViewTopPlayers: UICollectionView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempCloudLabel: UIImageView!
    
    
    @IBOutlet weak var betTeamOneLabel: UILabel!
    @IBOutlet weak var betTeamMidleLabel: UILabel!
    @IBOutlet weak var betTeamTwoLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //MARK: - We get data from the database
    private var players: Results<Player>!
    
    //    let pl = Player()
    private var networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        players = realm.objects(Player.self)
        Team.shared.overallRating(players)
        
        weatherSettings()
        CalendarFooTeam.shared.timeFoot(timeLabel)
        
        tabBarItems()
        //        pl.savePlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableViewAndCollectionViewSettings()
        segmentedControlSettings()
        Team.shared.bet(players,
                        betTeamOneLabel,
                        betTeamTwoLabel,
                        betTeamMidleLabel)
    }
    
    @IBAction func segmentedControlChoice(_ sender: UISegmentedControl) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            tableViewNewPlayers.reloadData()
        } else {
            tableViewNewPlayers.reloadData()
        }
    }
    
    //MARK: - Data transfer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "HomeSeguetoPS" {
            let personStatSegueVC = segue.destination as! PersonalStatisticsController
            personStatSegueVC.player = sender as? Player
        }
    }
    
    //MARK: - API parse Weather
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
    
    // MARK: - TabBar Items
    private func tabBarItems() {
        let tabItems = tabBarController?.tabBar.items
        tabItems?[1].badgeValue = "+1"
    }
    
    // MARK: - Settings
    private func tableViewAndCollectionViewSettings() {
        tableViewNewPlayers.reloadData()
        tableViewNewPlayers.tableFooterView = UIView()
        collectionViewTopPlayers.reloadData()
    }
    
    private func segmentedControlSettings() {
        Team.shared.segmentedControlInsertTeam(players, segmentedControl)
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func weatherSettings() {
        onCompletionWeather()
        networkWeatherManager.fetchCurrentWeather()
    }
    
}

// MARK: - TOP-players, Collection View DataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let players = self.players.filter("\(Team.rating)").sorted(byKeyPath: "rating", ascending: false)
        return players.isEmpty ? 0 : players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionView", for: indexPath) as! CellViewController
        
        let players = self.players.filter("\(Team.rating)").sorted(byKeyPath: "rating", ascending: false)
        let player = players[indexPath.row]
        
        cell.imageCell.image = UIImage(data: player.photo!)
        cell.labelCell.text = player.name
        DispatchQueue.main.async {
            cell.imageCell.layer.cornerRadius = cell.imageCell.frame.size.height / 2
            cell.imageCell.layer.borderWidth = 2
            cell.imageCell.layer.borderColor = #colorLiteral(red: 1, green: 0.4017014802, blue: 0.3975783288, alpha: 1)
        }
        return cell
    }
}

// MARK: - TOP-players, Collection View Delegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let players = self.players.filter("\(Team.rating)").sorted(byKeyPath: "rating", ascending: false)
        let player = players[indexPath.row]
        performSegue(withIdentifier: "HomeSeguetoPS", sender: player)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - List teams, Table view data source

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 1")
            return players.isEmpty ? 0 : players.count
        case 1:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 2")
            return players.isEmpty ? 0 : players.count
        case 2:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 3")
            return players.isEmpty ? 0 : players.count
        case 3:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 4")
            return players.isEmpty ? 0 : players.count
        default:
            return players.isEmpty ? 0 : players.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNewPlayer", for: indexPath) as! MainNewPlayersTableViewCell
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 1").sorted(byKeyPath: "rating", ascending: false)
            
            let player = players[indexPath.row]
            cell.namePlayers.text = player.name
            cell.rating.text = "\(player.rating)"
            return cell
        case 1:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 2").sorted(byKeyPath: "rating", ascending: false)
            let player = players[indexPath.row]
            cell.namePlayers.text = player.name
            cell.rating.text = "\(player.rating)"
            return cell
        case 2:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 3").sorted(byKeyPath: "rating", ascending: false)
            let player = players[indexPath.row]
            cell.namePlayers.text = player.name
            cell.rating.text = "\(player.rating)"
            return cell
        case 3:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 4").sorted(byKeyPath: "rating", ascending: false)
            let player = players[indexPath.row]
            cell.namePlayers.text = player.name
            cell.rating.text = "\(player.rating)"
            return cell
        default:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 0").sorted(byKeyPath: "rating", ascending: false)
            let player = players[indexPath.row]
            cell.namePlayers.text = player.name
            cell.rating.text = "\(player.rating)"
            return cell
        }
    }
}

// MARK: - List teams, Table view Delegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 1").sorted(byKeyPath: "rating", ascending: false)
            
            let player = players[indexPath.row]
            performSegue(withIdentifier: "HomeSeguetoPS", sender: player)
            tableView.deselectRow(at: indexPath, animated: true)
        case 1:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 2").sorted(byKeyPath: "rating", ascending: false)
            
            let player = players[indexPath.row]
            performSegue(withIdentifier: "HomeSeguetoPS", sender: player)
            tableView.deselectRow(at: indexPath, animated: true)
        case 2:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 3").sorted(byKeyPath: "rating", ascending: false)
            
            let player = players[indexPath.row]
            performSegue(withIdentifier: "HomeSeguetoPS", sender: player)
            tableView.deselectRow(at: indexPath, animated: true)
        case 3:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 4").sorted(byKeyPath: "rating", ascending: false)
            
            let player = players[indexPath.row]
            performSegue(withIdentifier: "HomeSeguetoPS", sender: player)
            tableView.deselectRow(at: indexPath, animated: true)
        default:
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 0").sorted(byKeyPath: "rating", ascending: false)
            
            let player = players[indexPath.row]
            performSegue(withIdentifier: "HomeSeguetoPS", sender: player)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
