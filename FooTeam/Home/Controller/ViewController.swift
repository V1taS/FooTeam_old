//
//  ViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var nameTemOne: [UILabel]!
    @IBOutlet var nameTemTwo: [UILabel]!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempCloudLabel: UIImageView!
    
    @IBOutlet var reserve: [UILabel]!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModelOnlyNameTeam.shared.getTeamOne(players: Team.shared.reserve,
                                            name: reserve)
        
        ModelOnlyNameTeam.shared.getTeamOne(players: Team.shared.teamOne,
                                            name: nameTemOne)
        
        ModelOnlyNameTeam.shared.getTeamOne(players: Team.shared.teamTwo,
                                            name: nameTemTwo)
        
        TimeFoot.shared.timeFoot(timeLabel: timeLabel)
        onCompletionWeather()
        networkWeatherManager.fetchCurrentWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        let playersAddVC = segue.source as! AddPlayerTableViewController
//        users.append(userManagerVC.userNameTextField.text ?? "Noname")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeSegue" {
            let personStatSegueVC = segue.destination as! PersonalStatisticsController
            personStatSegueVC.team = sender as? Player
        }
    }
    
    // MARK: - API parse
    private func onCompletionWeather() {
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
    }
    
    private func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.tempCloudLabel.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
}
