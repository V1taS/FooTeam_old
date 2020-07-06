//
//  ListNameTableView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 22.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import RealmSwift

enum CurrentTeam {
    case teamOne, teamTwo, teamFree, teamFour
}

class ListNameTableView: UITableViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    var players: Results<Player>!
    var currenTeam = CurrentTeam.teamOne
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        players = realm.objects(Player.self)
        
        navBar.title = "Играют - \(self.players.filter("isFavourite = true").count), В команде - \(self.players.filter("inTeam = true").count)"
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        players = realm.objects(Player.self)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            if segue.identifier == "ListNameTableViewSegue" {
                let personStatSegueVC = segue.destination as! PersonalStatisticsController
                personStatSegueVC.player = sender as? Player
                personStatSegueVC.indexPath = indexPath
            }
        }
    }
    
    // Метод который отрабатывает выход из ViewController
    @IBAction func unwindSegueListSave(_ segue: UIStoryboardSegue) {
        
        guard let addVC = segue.source as? AddPlayerTableViewController else { return }
        addVC.saveNewPlayer()
        tableView.reloadData()
    }
    
    @IBAction func refreshTeam(_ sender: UIBarButtonItem) {
        
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
        
        switch countTeams {
        case 2:
            // сортируем игроков по возрастанию и распределяем по командам
            for player in self.players.filter("isFavourite = true").sorted(byKeyPath: "rating", ascending: false) {
                switch currenTeam {
                    
                case .teamOne:
                    try! realm.write {
                        player.teamNumber = 1
                    }
                    currenTeam = .teamTwo
                case .teamTwo:
                    try! realm.write {
                        player.teamNumber = 2
                    }
                    currenTeam = .teamOne
                case .teamFree:
                    print("Error Sort players case 2")
                case .teamFour:
                    print("Error Sort players case 2")
                }
            }
        case 3:
            // сортируем игроков по возрастанию и распределяем по командам
            for player in self.players.filter("isFavourite = true").sorted(byKeyPath: "rating", ascending: false) {
                switch currenTeam {
                    
                case .teamOne:
                    try! realm.write {
                        player.teamNumber = 1
                    }
                    currenTeam = .teamTwo
                case .teamTwo:
                    try! realm.write {
                        player.teamNumber = 2
                    }
                    currenTeam = .teamFree
                case .teamFree:
                    try! realm.write {
                        player.teamNumber = 3
                    }
                    currenTeam = .teamOne
                case .teamFour:
                    print("Error Sort players case 3")
                }
            }
        case 4:
            // сортируем игроков по возрастанию и распределяем по командам
            for player in self.players.filter("isFavourite = true").sorted(byKeyPath: "rating", ascending: false) {
                switch currenTeam {
                    
                case .teamOne:
                    try! realm.write {
                        player.teamNumber = 1
                    }
                    currenTeam = .teamTwo
                case .teamTwo:
                    try! realm.write {
                        player.teamNumber = 2
                    }
                    currenTeam = .teamFree
                case .teamFree:
                    try! realm.write {
                        player.teamNumber = 3
                    }
                    currenTeam = .teamFour
                case .teamFour:
                    try! realm.write {
                        player.teamNumber = 4
                    }
                    currenTeam = .teamOne
                }
            }
        default:
            // сортируем игроков по возрастанию и распределяем по командам
            for player in self.players.filter("isFavourite = true").sorted(byKeyPath: "rating", ascending: false) {
                switch currenTeam {
                    
                case .teamOne:
                    try! realm.write {
                        player.teamNumber = 1
                    }
                    currenTeam = .teamTwo
                case .teamTwo:
                    try! realm.write {
                        player.teamNumber = 2
                    }
                    currenTeam = .teamOne
                case .teamFree:
                    print("Error Sort players case 2")
                case .teamFour:
                    print("Error Sort players case 2")
                }
            }
        }
        
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersCell", for: indexPath) as! ListNameTableViewCell
        
        let players = self.players.sorted(byKeyPath: "inTeam", ascending: false)
        
        let player = players[indexPath.row]
        
        // Имя игрока
        cell.namePlayer.text = player.name
        cell.ratingPlayer.text = "Рейтинг: \(player.rating)"
        cell.numberOfGamesLeft.text = "Баланс: \(player.payment) руб."
        cell.positionPlayer.text = player.position
        
        if player.teamNumber == 1 {
            cell.teamSelection.text = "Команда: 1️⃣"
        } else if player.teamNumber == 2 {
            cell.teamSelection.text = "Команда: 2️⃣"
        } else if player.teamNumber == 3 {
            cell.teamSelection.text = "Команда: 3️⃣"
        } else if player.teamNumber == 4 {
            cell.teamSelection.text = "Команда: 4️⃣"
        } else {
            cell.teamSelection.text = "Команда: 🤷🏻‍♂️"
        }
        
        if player.isFavourite {
            cell.iGo.textColor = .green
        } else {
            cell.iGo.textColor = .red
        }
        
        if UIImage(data: player.photo!) == nil {
            cell.imagePlayer.image = UIImage(data: player.photo!)
        } else {
            cell.imagePlayer.image = UIImage(data: player.photo!)
        }
        
        // Скруглили Imageview
        cell.imagePlayer.layer.cornerRadius = cell.imagePlayer.frame.size.height / 20
        // Обрезали по краям
        cell.imagePlayer.clipsToBounds = true
        
        if player.inTeam {
            cell.imagePlayer.layer.borderWidth = 1
            cell.imagePlayer.layer.borderColor = UIColor.green.cgColor
        } else {
            cell.imagePlayer.layer.borderWidth = 1
            cell.imagePlayer.layer.borderColor = UIColor.systemGray5.cgColor
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let players = self.players.sorted(byKeyPath: "inTeam", ascending: false)
        let player = players[indexPath.row]
        performSegue(withIdentifier: "ListNameTableViewSegue", sender: player)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Delete players from listItem
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let player = players[indexPath.row]
            StorageManager.deletePlayer(player)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Leading Swipe Actions
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favourite = favouriteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [favourite])
    }
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        let playersSorted = self.players.sorted(byKeyPath: "inTeam", ascending: false)
        let player = playersSorted[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "I GO") { (action, view, completion) in
            try! realm.write {
                player.isFavourite = !player.isFavourite
            }
            self.tableView.reloadRows(at: [indexPath], with: .top)
            self.navBar.title = "Играют - \(self.players.filter("isFavourite = true").count), В команде - \(self.players.filter("inTeam = true").count)"
            completion(true)
        }
        action.backgroundColor = player.isFavourite ? #colorLiteral(red: 0, green: 0.364138335, blue: 0.1126995459, alpha: 1) : .systemGray
        action.image = UIImage(systemName: "person.badge.plus")
        return action
    }
}
