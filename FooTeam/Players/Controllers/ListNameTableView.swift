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
    
}
