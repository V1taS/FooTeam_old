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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomeTableViewCell
        
        let player = listItem[indexPath.row]
        
        // Имя игрока
        cell.namePlayerOutlet.text = player.name
        
        cell.positionPlayeroutlet.text = player.teamNumber
        
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
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
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

}
