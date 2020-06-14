//
//  ListNameTableView.swift
//  FooTeam
//
//  Created by Виталий Сосин on 22.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class ListNameTableView: UITableViewController {
    
    // Основной Функционал в ModelList
    var listItem = Player.getPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayersSegue" {
            let personStatSegueVC = segue.destination as! PersonalStatisticsController
            personStatSegueVC.team = sender as? Player
        }
    }
    
   
    
    // Метод который отрабатывает выход из ViewController
    // Мы на него будем ссылаться
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newVC = segue.source as? AddPlayerTableViewController else { return }
        
        // Обращаемся к методу который сохраняет данные
        newVC.saveNewPlace()
        
        listItem.append(newVC.newPlayer!)
        
        // Перезагружаем tableView
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersCell", for: indexPath) as! CustomeTableViewCell
        
        let player = listItem[indexPath.row]
        
        // Имя игрока
        cell.namePlayerOutlet.text = player.name
        
        cell.positionPlayeroutlet.text = ""
        
        if player.image == nil {
            cell.imageOutlet.image = UIImage(named: player.imageStatic!)
        } else {
            cell.imageOutlet.image = player.image
        }
        
        // Скруглили Imageview
        cell.imageOutlet.layer.cornerRadius = cell.imageOutlet.frame.size.height / 2
        // Обрезали по краям
        cell.imageOutlet.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let player = Team.shared.teamAll[indexPath.row]
        performSegue(withIdentifier: "PlayersSegue", sender: player)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Delet players from listItem
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listItem.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Move players from listItem
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movePlayers = listItem.remove(at: sourceIndexPath.row)
        listItem.insert(movePlayers, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    // MARK: - Leading Swipe Actions
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [favourite])
    }
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = listItem[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "I GO") { (action, view, completion) in
            object.isFavourite = !object.isFavourite
            self.listItem[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavourite ? #colorLiteral(red: 0, green: 0.364138335, blue: 0.1126995459, alpha: 1) : .systemGray
        action.image = UIImage(systemName: "person.badge.plus")
        return action
    }
    
}
