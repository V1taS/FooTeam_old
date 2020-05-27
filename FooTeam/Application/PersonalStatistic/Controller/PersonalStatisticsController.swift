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
    
    var team: Player!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rating.text = String(team.rating)
        position.text = team.position!
        
        namePlayers.text = team.name
        photoPlayers.image = UIImage(named: team.imageStatic!)
        photoPlayers.layer.cornerRadius = photoPlayers.frame.width / 2
        
        numberOfGames.text = String(team.numberOfGames)
        numberOfGoals.text = String(team.numberOfGoals)
        
        winGame.text = String(team.winGame)
        losGame.text = String(team.losGame)
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userManagerVC = segue.destination as! AddPlayerTableViewController
        userManagerVC.team = team
        userManagerVC.editModeIsOn = true
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        let userManagerVC = segue.source as! AddPlayerTableViewController
//        userNameLabel.text = userManagerVC.userNameTextField.text
    }
    
}
