//
//  MainViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var nameTemOne: [UILabel]!
    @IBOutlet var nameTemTwo: [UILabel]!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempCloudLabel: UIImageView!
    
    @IBOutlet var reserve: [UILabel]!
    
    var db: Firestore!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    var dbPlayers: [Player] = []
    
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
        
        db = Firestore.firestore()
        
        print("viewDidLoad - TEST")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addPlayers()
        print("viewWillAppear - TEST")
        
        tableView.reloadData()
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        let playersAddVC = segue.source as! AddPlayerTableViewController
        //        users.append(userManagerVC.userNameTextField.text ?? "Noname")
    }
    
    @IBAction func appActions(_ sender: UIBarButtonItem) {
        addPlayers()
    }
    
    func addPlayers() {
        db.collection("players").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
//                                        print("\(document.documentID) => \(document.data())")
                    guard let players = Player.init(dictionary: document.data()) else { return }
                    self.dbPlayers.append(players)
                    print("Functions - TEST")
//                    let player = Player(name: players.name,
//                                        teamNumber: players.teamNumber,
//                                        payment: players.payment,
//                                        isFavourite: players.isFavourite,
//                                        rating: players.rating,
//                                        position: players.position,
//                                        numberOfGames: players.numberOfGames,
//                                        numberOfGoals: players.numberOfGoals,
//                                        winGame: players.winGame,
//                                        losGame: players.losGame)
//                    dbPlayers.append(player)
//                    print(dbPlayers)
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeSegue" {
            let personStatSegueVC = segue.destination as! PersonalStatisticsController
            personStatSegueVC.team = sender as? Player
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
    
}
// MARK: - Collection View DataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Team.shared.teamOne.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionView", for: indexPath) as! CellViewController
        
        cell.imageCell.image = UIImage(named: Team.shared.teamOne[indexPath.row].imageStatic!)
        cell.labelCell.text = Team.shared.teamOne[indexPath.row].name
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.size.height / 2
        cell.imageCell.clipsToBounds = true
        return cell
    }
}

// MARK: - Collection View Delegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let player = Team.shared.teamAllRandom[indexPath.row]
        performSegue(withIdentifier: "HomeSegue", sender: player)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - Table view data source

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return Team.shared.teamTwo.count
        return dbPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNewPlayer", for: indexPath) as! NewplayerTableViewCell
        let player = Team.shared.teamTwo[indexPath.row]
        
        cell.namePlayers.text = dbPlayers[indexPath.row].name
        //        cell.imagePlayers.image = UIImage(named: player.imageStatic!)
        
        //        cell.imagePlayers.layer.cornerRadius = cell.imagePlayers.frame.width / 2
        
        return cell
    }
}

// MARK: - Table view Delegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let player = Team.shared.teamAllRandom[indexPath.row]
        performSegue(withIdentifier: "HomeSegue", sender: player)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
