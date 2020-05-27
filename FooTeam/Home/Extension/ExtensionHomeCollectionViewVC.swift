//
//  ExtensionHomeCollectionViewVC.swift
//  FooTeam
//
//  Created by Виталий Сосин on 27.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

// MARK: - Collection View DataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Team.shared.teamOne.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionView", for: indexPath) as! CellViewController
        
        cell.imageCell.image = UIImage(named: Team.shared.teamOne[indexPath.row].imageStatic!)
        cell.labelCell.text = Team.shared.teamOne[indexPath.row].name
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.size.height / 2
        cell.imageCell.clipsToBounds = true
        return cell
    }
}

// MARK: - Collection View Delegate

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let player = Team.shared.teamAllRandom[indexPath.row]
        performSegue(withIdentifier: "HomeSegue", sender: player)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
