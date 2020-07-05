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
    
    //MARK: - Получаем данные из базы
    var players: Results<Player>!
    
    let pl = Player()
    
    var networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - инициализируем объект players
        players = realm.objects(Player.self)
        
        timeFoot(timeLabel: timeLabel)
        onCompletionWeather()
        networkWeatherManager.fetchCurrentWeather()
        
        tableViewNewPlayers.reloadData()
        collectionViewTopPlayers.reloadData()
        
        //        pl.savePlayer()
        segmentedControlTitel()
        bet()
        tableViewNewPlayers.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: - инициализируем объект players
        players = realm.objects(Player.self)
        bet()
        
        tableViewNewPlayers.reloadData()
        collectionViewTopPlayers.reloadData()
        
        segmentedControlTitel()
        
        tableViewNewPlayers.tableFooterView = UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "HomeSeguetoPS" {
                let personStatSegueVC = segue.destination as! PersonalStatisticsController
                personStatSegueVC.player = sender as? Player
            }
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
    
    private func timeFoot(timeLabel: UILabel) {
        let date = Date()
        let calendar = Calendar.current
        
        let weekday = calendar.component(.weekday, from: date)
        
        switch weekday {
        case 1:
            //            print("Сегодня Воскресенье")
            timeLabel.text = " через: 2 дня"
        case 2:
            //            print("Сегодня Понедельник")
            timeLabel.text = " через: день"
        case 3:
            //            print("Сегодня Вторник")
            timeLabel.text = " завтра"
        case 4:
            //            print("Сегодня Среда")
            timeLabel.text = " сегодня"
            timeLabel.textColor = .green
        case 5:
            //            print("Сегодня Четверг")
            timeLabel.text = " через: 5 дней"
        case 6:
            //            print("Сегодня Пятница")
            timeLabel.text = " через: 4 дня"
        case 7:
            //            print("Сегодня Суббота")
            timeLabel.text = " через: 3 дня"
        default:
            print("Error")
        }
    }
    @IBAction func segmentedControlChoice(_ sender: UISegmentedControl) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            tableViewNewPlayers.reloadData()
            segmentedControlTitel()
        } else {
            segmentedControlTitel()
            tableViewNewPlayers.reloadData()
        }
    }
    
    private func bet() {
        let teamOne = self.players.filter("isFavourite = true").filter("teamNumber = 1")
        let teamTwo = self.players.filter("isFavourite = true").filter("teamNumber = 2")
        var teamOneTotal = 0
        var teamTwoTotal = 0
        
        for player in teamOne {
            teamOneTotal += player.rating
        }
        
        for player in teamTwo {
            teamTwoTotal += player.rating
        }
        
        let targetOneTotal = String(format: "%.1f", Double(teamOneTotal) / 99 / 2 + 1)
        let targetTwoTotal = String(format: "%.1f", Double(teamTwoTotal) / 99 / 2 + 1)
         let targetMidleTotal = String(format: "%.1f", (Double(teamOneTotal) / 99 - Double(teamTwoTotal) / 99) + 1 )
        
        betTeamOneLabel.text = targetOneTotal
        betTeamTwoLabel.text = targetTwoTotal
        betTeamMidleLabel.text = targetMidleTotal
    }
    
    private func segmentedControlTitel() {
        segmentedControl.setTitle("Команда - 1 (\(self.players.filter("isFavourite = true").filter("teamNumber = 1").count))", forSegmentAt: 0)
        segmentedControl.setTitle("Команда - 2 (\(self.players.filter("isFavourite = true").filter("teamNumber = 2").count))", forSegmentAt: 1)
    }
    
}
// MARK: - Collection View DataSource

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
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.size.height / 2
        cell.imageCell.clipsToBounds = true
        
        cell.imageCell.layer.borderWidth = 2
        cell.imageCell.layer.borderColor = #colorLiteral(red: 1, green: 0.4017014802, blue: 0.3975783288, alpha: 1)
        return cell
    }
}

// MARK: - Collection View Delegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let players = self.players.filter("\(Team.rating)").sorted(byKeyPath: "rating", ascending: false)
        let player = players[indexPath.row]
        performSegue(withIdentifier: "HomeSeguetoPS", sender: player)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - Table view data source

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 1")
            return players.isEmpty ? 0 : players.count
        } else {
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 2")
            return players.isEmpty ? 0 : players.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNewPlayer", for: indexPath) as! MainNewPlayersTableViewCell
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 1").sorted(byKeyPath: "name", ascending: true)
            
            let player = players[indexPath.row]
            cell.namePlayers.text = player.name
            cell.rating.text = "\(player.rating)"
            return cell
        } else {
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 2").sorted(byKeyPath: "name", ascending: true)
            let player = players[indexPath.row]
            cell.namePlayers.text = player.name
            cell.rating.text = "\(player.rating)"
            return cell
        }
    }
}

// MARK: - Table view Delegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 1").sorted(byKeyPath: "name", ascending: true)
            
            let player = players[indexPath.row]
            performSegue(withIdentifier: "HomeSeguetoPS", sender: player)
            tableView.deselectRow(at: indexPath, animated: true)
            
        } else {
            let players = self.players.filter("isFavourite = true").filter("teamNumber = 2").sorted(byKeyPath: "name", ascending: true)
            
            let player = players[indexPath.row]
            performSegue(withIdentifier: "HomeSeguetoPS", sender: player)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
