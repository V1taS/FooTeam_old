//
//  ViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 22.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var players = Player.getPlayer()
    
    // TEAM-1 IMAGE
    @IBOutlet weak var imageTeam1Number_1: UIImageView!
    @IBOutlet weak var imageTeam1Number_2: UIImageView!
    @IBOutlet weak var imageTeam1Number_3: UIImageView!
    @IBOutlet weak var imageTeam1Number_4: UIImageView!
    @IBOutlet weak var imageTeam1Number_5: UIImageView!
    @IBOutlet weak var imageTeam1Number_6: UIImageView!
    
    // TEAM-2
    @IBOutlet weak var imageTeam2Number_1: UIImageView!
    @IBOutlet weak var imageTeam2Number_2: UIImageView!
    @IBOutlet weak var imageTeam2Number_3: UIImageView!
    @IBOutlet weak var imageTeam2Number_4: UIImageView!
    @IBOutlet weak var imageTeam2Number_5: UIImageView!
    @IBOutlet weak var imageTeam2Number_6: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageTeam1Number_1.image = UIImage(named: "Александр Фадеев")
        imageTeam1Number_2.image = UIImage(named: "Александр Руховец")
        imageTeam1Number_3.image = UIImage(named: "Павел Богданов")
        imageTeam1Number_4.image = UIImage(named: "Артур Илларионов")
        imageTeam1Number_5.image = UIImage(named: "Андрей Пахомов")
        imageTeam1Number_6.image = UIImage(named: "Александр Добров")
        
        imageTeam2Number_1.image = UIImage(named: "Владимир Мельников")
        imageTeam2Number_2.image = UIImage(named: "Егор Малахов")
        imageTeam2Number_3.image = UIImage(named: "Андрей Смирнов")
        imageTeam2Number_4.image = UIImage(named: "Сосин Виталий")
        imageTeam2Number_5.image = UIImage(named: "Илья Гордеев")
        imageTeam2Number_6.image = UIImage(named: "Обрадович Милан")

    }


}

