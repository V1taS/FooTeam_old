//
//  CommandStructureTableViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 02.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import RealmSwift

class CommandStructureTableViewController: UITableViewController {
    
    //MARK: - Получаем данные из базы
    var players: Results<Player>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - инициализируем объект players
        players = realm.objects(Player.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return players.count
    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCommandStructure", for: indexPath)


        return cell
    }
    
    // Использование метода для кастомизации секции без использования кастомного класса
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        let label = UILabel(frame: CGRect(x: 20, y: 3, width: 300, height: 20))
        label.text = players[section].name
        label.textColor = .black
        
        headerView.addSubview(label)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = .gray
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    //Использование метода для присваивания заголовка секции
       /*
       override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           persons[section].fullName
       }
       */
       
       
       // Использование метода для кастомизации секции с использованием кастомного класса
       /*
       override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
           
           headerCell.personLabel.text = persons[section].fullName
           
           return headerCell
           
       }
       */
       
       // Использование метода для кастомизации секции без использования кастомного класса
       /*
       override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                   
           let label = UILabel()
           label.text = persons[section].fullName
           label.textColor = .white
           label.textAlignment = .center
           label.font = UIFont.boldSystemFont(ofSize: 24)
           
           return label
       }
       */
}
