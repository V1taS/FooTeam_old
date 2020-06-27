//
//  MainViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var nameTemOne: [UILabel]!
    @IBOutlet var nameTemTwo: [UILabel]!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempCloudLabel: UIImageView!
    
    @IBOutlet var reserve: [UILabel]!
    
    var players = Team.shared.teamAll
    
    var networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        players = Team.shared.teamAll
        
        OnlyName.shared.getTeamOne(players: Team.shared.reserve,
                                   name: reserve)
        
        OnlyName.shared.getTeamOne(players: Team.shared.teamOne,
                                   name: nameTemOne)
        
        OnlyName.shared.getTeamOne(players: Team.shared.teamTwo,
                                   name: nameTemTwo)
        
        timeFoot(timeLabel: timeLabel)
        onCompletionWeather()
        networkWeatherManager.fetchCurrentWeather()
        
        tableView.reloadData()
    }
    
    @IBAction func unwindSegueMain(segue: UIStoryboardSegue) {
        let playersAddVC = segue.source as! AddPlayerTableViewController
        //        users.append(userManagerVC.userNameTextField.text ?? "Noname")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeSeguetoPS" {
            let personStatSegueVC = segue.destination as! PersonalStatisticsController
            personStatSegueVC.players = sender as? Player
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
            timeLabel.text = "через: 3 дня"
        case 2:
//            print("Сегодня Понедельник")
            timeLabel.text = "через: 2 дня"
        case 3:
//            print("Сегодня Вторник")
            timeLabel.text = "через: 1 день"
        case 4:
//            print("Сегодня Среда")
            timeLabel.text = ": завтра"
        case 5:
//            print("Сегодня Четверг")
            timeLabel.text = ": сегодня"
            timeLabel.textColor = .red
        case 6:
//            print("Сегодня Пятница")
            timeLabel.text = ": была вчера"
        case 7:
//            print("Сегодня Суббота")
            timeLabel.text = "через: 4 дня"
        default:
            print("Error")
        }
    }
}
// MARK: - Collection View DataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionView", for: indexPath) as! CellViewController
        let player = players[indexPath.row]
        
        cell.imageCell.image = UIImage(data: player.photo)
        cell.labelCell.text = player.name
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.size.height / 2
        cell.imageCell.clipsToBounds = true
        return cell
    }
}

// MARK: - Collection View Delegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let player = players[indexPath.row]
        performSegue(withIdentifier: "HomeSeguetoPS", sender: player)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - Table view data source

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNewPlayer", for: indexPath) as! MainNewPlayersTableViewCell
        
        let player = players[indexPath.row]
        
        cell.namePlayers.text = player.name
        cell.imagePlayers.image = UIImage(data: player.photo)
        
        cell.imagePlayers.layer.cornerRadius = cell.imagePlayers.frame.width / 2
        
        return cell
    }
}

// MARK: - Table view Delegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let player = players[indexPath.row]
        performSegue(withIdentifier: "HomeSeguetoPS", sender: player)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
