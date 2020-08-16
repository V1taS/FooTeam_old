//
//  AddAvaTeamsView.swift
//  iChat
//
//  Created by Виталий Сосин on 10.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class AddAvaTeamsView: UIView {
    
    var circleAvaTeamsImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "khimki")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let myImage = #imageLiteral(resourceName: "plus")
        button.setImage(myImage, for: .normal)
        button.tintColor = .buttonDark()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(circleAvaTeamsImageView)
        addSubview(plusButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            circleAvaTeamsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            circleAvaTeamsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            circleAvaTeamsImageView.widthAnchor.constraint(equalToConstant: 100),
            circleAvaTeamsImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            plusButton.leadingAnchor.constraint(equalTo: circleAvaTeamsImageView.trailingAnchor, constant: 16),
            plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        self.bottomAnchor.constraint(equalTo: circleAvaTeamsImageView.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleAvaTeamsImageView.layer.masksToBounds = true
        circleAvaTeamsImageView.layer.cornerRadius = circleAvaTeamsImageView.frame.width / 2
    }
}

