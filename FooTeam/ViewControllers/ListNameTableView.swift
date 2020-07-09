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
    private var players: Results<Player>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        players = realm.objects(Player.self)
        navBar.title = "Играют - \(self.players.filter("isFavourite = true").count), В команде - \(self.players.filter("inTeam = true").count)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Data transfer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            if segue.identifier == "ListNameTableViewSegue" {
                let personStatSegueVC = segue.destination as! PersonalStatisticsController
                personStatSegueVC.player = sender as? Player
                personStatSegueVC.indexPath = indexPath
            }
        }
    }
    
    // MARK: - A method that works out of ViewController
    @IBAction func unwindSegueListSave(_ segue: UIStoryboardSegue) {
        guard let addVC = segue.source as? AddPlayerTableViewController else { return }
        addVC.saveNewPlayer()
        tableView.reloadData()
    }
    
    // MARK: - Sort players into teams
    @IBAction func refreshTeam(_ sender: UIBarButtonItem) {
        Team.shared.getListOfTeams(players)
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
    
    // MARK: - Table view Delegate
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
