//
//  ListNameTableView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 22.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import RealmSwift

class ListNameTableView: UITableViewController {
    
    var players: Results<Player>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        players = realm.objects(Player.self)
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            if segue.identifier == "ListNameTableViewSegue" {
                let personStatSegueVC = segue.destination as! PersonalStatisticsController
                personStatSegueVC.players = sender as? Player
                personStatSegueVC.indexPath = indexPath
            }
        }
    }
    
    // Метод который отрабатывает выход из ViewController
    // Мы на него будем ссылаться
    @IBAction func unwindSegueListSave(_ segue: UIStoryboardSegue) {
        
        guard let addVC = segue.source as? AddPlayerTableViewController else { return }
        
        // Обращаемся к методу который сохраняет данные
        addVC.saveNewPlayer()
//        players = StorageManager.shared.fetchPlayers()
        // Перезагружаем tableView
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersCell", for: indexPath) as! ListNameTableViewCell
        
        let player = players[indexPath.row]
        
        // Имя игрока
        cell.namePlayer.text = player.name
        cell.ratingPlayer.text = "Райтинг: \(player.rating)"
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
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
    // MARK: - Move players from listItem
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movePlayers = players[sourceIndexPath.row]
        StorageManager.deletePlayer(movePlayers)
        
//        players.insert(movePlayers, at: destinationIndexPath.row)
//        StorageManager.shared.insertPlayer(player: movePlayers, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    // MARK: - Leading Swipe Actions
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favourite = favouriteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [favourite])
    }
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        
        let player = players[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "I GO") { (action, view, completion) in

            try! realm.write {
                player.isFavourite = !player.isFavourite
            }
            
            self.tableView.reloadRows(at: [indexPath], with: .top)
            completion(true)
        }
        action.backgroundColor = player.isFavourite ? #colorLiteral(red: 0, green: 0.364138335, blue: 0.1126995459, alpha: 1) : .systemGray
        action.image = UIImage(systemName: "person.badge.plus")
//        StorageManager.shared.reSavePlayer(player: object, at: indexPath.row)
        return action
    }
    
}
