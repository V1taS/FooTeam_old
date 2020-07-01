//
//  PersonalStatisticsController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 27.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class PersonalStatisticsController: UIViewController {
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var position: UILabel!
    
    @IBOutlet weak var namePlayers: UILabel!
    @IBOutlet weak var photoPlayers: UIImageView!
    
    @IBOutlet weak var numberOfGames: UILabel!
    @IBOutlet weak var numberOfGoals: UILabel!
    @IBOutlet weak var winGame: UILabel!
    @IBOutlet weak var losGame: UILabel!
    
    var players: Player!
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        rating.text = String(players.rating)
        position.text = players.position
        
        namePlayers.text = players.name
        photoPlayers.image = UIImage(data: players.photo!)
        photoPlayers.layer.cornerRadius = photoPlayers.frame.width / 2
        
//        numberOfGames.text = String(players.numberOfGames)
//        numberOfGoals.text = String(players.numberOfGoals)
//
//        winGame.text = String(players.winGame)
//        losGame.text = String(players.losGame)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditePlayerTableViewControllerSegue" {
            let editePlayerVC = segue.destination as! EditePlayerTableViewController
            editePlayerVC.players = players
            editePlayerVC.indexPath = self.indexPath
        }
    }
    
    // Метод который отрабатывает выход из ViewController
    // Мы на него будем ссылаться
    @IBAction func unwindSeguePersonal(_ segue: UIStoryboardSegue) {
        
        guard let editiVC = segue.source as? EditePlayerTableViewController else { return }
        
        editiVC.saveNewPlayer()
        
        players = editiVC.players
    }
}
