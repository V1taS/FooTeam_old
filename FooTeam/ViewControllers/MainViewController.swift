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
        
        let tabItems = tabBarController?.tabBar.items
        tabItems?[1].badgeValue = "+1"
        
        //MARK: - инициализируем объект players
        players = realm.objects(Player.self)
        
        timeFoot(timeLabel: timeLabel)
        onCompletionWeather()
        networkWeatherManager.fetchCurrentWeather()
        
        tableViewNewPlayers.reloadData()
        collectionViewTopPlayers.reloadData()
        
        //        pl.savePlayer()
        bet()
        forfardRating()
        havebekRating()
        protectionRating()
        goalkeaperRating()
        tableViewNewPlayers.tableFooterView = UIView()
        segmentedControlInsertTeam()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: - инициализируем объект players
        players = realm.objects(Player.self)
        bet()
        
        tableViewNewPlayers.reloadData()
        collectionViewTopPlayers.reloadData()
        
        tableViewNewPlayers.tableFooterView = UIView()
        segmentedControlInsertTeam()
        segmentedControl.selectedSegmentIndex = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "HomeSeguetoPS" {
            let personStatSegueVC = segue.destination as! PersonalStatisticsController
            personStatSegueVC.player = sender as? Player
        }
    }
    
    func goalkeaperRating() {
        for player in players.filter("position = 'ВРТ'") {
            
            var rating = 49
            
            let countGame = player.numberOfGames
            
            if countGame < 1 {
                rating += 1
            } else if countGame == 1 {
                
                if player.winGame == 1 {
                    rating += 36
                } else {
                    rating += 30
                }
                
            } else {
                
                if player.winGame > player.losGame {
                    rating += 36
                } else {
                    rating += 30
                }
            }
            
            if player.inTeam == true { rating += 7 }
            
            if rating >= 100 {
                try! realm.write {
                    player.rating = 99
                }
            } else {
                try! realm.write {
                    player.rating = rating
                }
            }
        }
    }
    
    func protectionRating() {
        for player in players.filter("position = 'ЦЗ'") {
            
            var rating = 49
            
            let countGame = player.numberOfGames
            let countGoals = player.numberOfGoals
            
            if countGame < 1 {
                rating += 1
            } else if countGame == 1 {
                
                if player.winGame == 1 {
                    rating += 32
                } else {
                    rating += 6
                }
                
                switch countGoals {
                case 0:
                    rating += 0
                case 1:
                    rating += 9
                default:
                    rating += 13
                }
                
            } else {
                
                let midleGoals = ((countGoals / countGame) * 19)
                
                if midleGoals > 40 {
                    rating += 41
                } else if midleGoals <= 10 {
                    rating += 21
                } else {
                    rating += midleGoals
                }
                
                if player.winGame > player.losGame {
                    rating += 22
                } else {
                    rating += 7
                }
            }
            
            if player.inTeam == true { rating += 7 }
            
            if rating >= 100 {
                try! realm.write {
                    player.rating = 99
                }
            } else {
                try! realm.write {
                    player.rating = rating
                }
            }
        }
    }
    
    func havebekRating() {
        for player in players.filter("position = 'ЦП'") {
            
            var rating = 49
            
            let countGame = player.numberOfGames
            let countGoals = player.numberOfGoals
            
            if countGame < 1 {
                rating += 1
            } else if countGame == 1 {
                
                if player.winGame == 1 {
                    rating += 12
                } else {
                    rating += 6
                }
                
                switch countGoals {
                case 0:
                    rating += 10
                case 1:
                    rating += 16
                case 2...3:
                    rating += 19
                default:
                    rating += 31
                }
                
            } else {
                
                let midleGoals = ((countGoals / countGame) * 19)
                
                if midleGoals > 40 {
                    rating += 41
                } else if midleGoals <= 10 {
                    rating += 21
                } else {
                    rating += midleGoals
                }
            }
            
            if player.inTeam == true { rating += 7 }
            
            if rating >= 100 {
                try! realm.write {
                    player.rating = 99
                }
            } else {
                try! realm.write {
                    player.rating = rating
                }
            }
        }
    }
    
    func forfardRating() {
        for player in players.filter("position = 'ФРВ'") {
            
            var rating = 49
            
            let countGame = player.numberOfGames
            let countGoals = player.numberOfGoals
            
            if countGame < 1 {
                rating += 1
            } else if countGame == 1 {
                rating += 10
                switch countGoals {
                case 0...1:
                    rating += 9
                case 2...3:
                    rating += 17
                case 4:
                    rating += 25
                default:
                    rating += 29
                }
            } else {
                
                let midleGoals = ((countGoals / countGame) * 19)
                
                if midleGoals > 40 {
                    rating += 37
                } else if midleGoals <= 10 {
                    rating += 22
                } else {
                    rating += midleGoals
                }
            }
            
            if player.inTeam == true { rating += 7 }
            
            if rating >= 100 {
                try! realm.write {
                    player.rating = 99
                }
            } else {
                try! realm.write {
                    player.rating = rating
                }
            }
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
        } else {
            tableViewNewPlayers.reloadData()
        }
    }
    
    func segmentedControlInsertTeam() {
        
        segmentedControl.removeAllSegments()
        let igoPlayers = self.players.filter("isFavourite = true")
        
        var countPlayersInTeam = 5
        let decrementIgoPlayers = igoPlayers.count - 1
        
        if igoPlayers.count % 5 == 0 || decrementIgoPlayers % 5 == 0  {
            countPlayersInTeam = 5
        }
        
        if igoPlayers.count % 6 == 0  || decrementIgoPlayers % 6 == 0  {
            countPlayersInTeam = 6
        }
        
        if igoPlayers.count % 7 == 0 {
            countPlayersInTeam = 7
        }
        
        let countTeams = igoPlayers.count / countPlayersInTeam
        
        for index in 0..<countTeams {
            segmentedControl.insertSegment(withTitle: "Команда - \(index + 1)",
                at: index,
                animated: false)
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
        
//        let targetOneTotal = String(format: "%.1f", Double(teamOneTotal) / 99 / 2 + 1)
//        let targetTwoTotal = String(format: "%.1f", Double(teamTwoTotal) / 99 / 2 + 1)
//        let targetMidleTotal = String(format: "%.1f", (Double(teamOneTotal) / 99 - Double(teamTwoTotal) / 99) + 1 )
        
        betTeamOneLabel.text = "..."
        betTeamTwoLabel.text = "..."
        betTeamMidleLabel.text = "..."
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
    
    // MARK: - Table view Delegate
    
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
