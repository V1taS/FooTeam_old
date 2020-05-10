//
//  ViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.04.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ViewController: UIViewController {
    @IBOutlet var playersField: [UILabel]!
    
    
    let listItem = Player.getPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var index = 0
        for i in Player.listTeam {
            playersField[index].text = i
            if index == 11 { break }
            index += 1
        }

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CellViewController
        
        // Configure the cell
        cell.imageCell.image = UIImage(named: listItem[indexPath.row].imageStatic!)
        
        cell.labelCell.text = listItem[indexPath.row].name
        
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.size.height / 2
        // Обрезали по краям
        cell.imageCell.clipsToBounds = true
        
        return cell
    }
    
    
}
