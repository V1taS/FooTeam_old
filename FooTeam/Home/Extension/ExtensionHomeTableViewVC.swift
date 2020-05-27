//
//  ExtensionHomeTableViewVC.swift
//  FooTeam
//
//  Created by Виталий Сосин on 27.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

// MARK: - Table view data source

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Team.shared.teamTwo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNewPlayer", for: indexPath) as! NewplayerTableViewCell
        let player = Team.shared.teamTwo[indexPath.row]
        
        cell.namePlayers.text = player.name
        cell.imagePlayers.image = UIImage(named: player.imageStatic!)
        
        cell.imagePlayers.layer.cornerRadius = cell.imagePlayers.frame.width / 2
        
        return cell
    }
}

// MARK: - Table view Delegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let player = Team.shared.teamAllRandom[indexPath.row]
        performSegue(withIdentifier: "HomeSegue", sender: player)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
