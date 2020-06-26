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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rating.text = String(players.rating)
        position.text = players.position
        
        namePlayers.text = players.name
        photoPlayers.image = UIImage(data: players.photo)
        photoPlayers.layer.cornerRadius = photoPlayers.frame.width / 2
        
        numberOfGames.text = String(players.numberOfGames)
        numberOfGoals.text = String(players.numberOfGoals)
        
        winGame.text = String(players.winGame)
        losGame.text = String(players.losGame)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userManagerVC = segue.destination as! AddPlayerTableViewController
        userManagerVC.players = players
        userManagerVC.editModeIsOn = true
    }
    
//    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
//        let userManagerVC = segue.source as! AddPlayerTableViewController
////        userNameLabel.text = userManagerVC.userNameTextField.text
//    }
    
}
