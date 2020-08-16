//
//  CreateTeamViewController.swift
//  iChat
//
//  Created by Виталий Сосин on 10.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import SwiftUI
import FirebaseAuth
import SDWebImage

class CreateTeamViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Создание команды", font: .bolt20(), textAlignment: .center)
    
    let fullImageView = AddAvaTeamsView()
    
    let nameLabel = UILabel(text: "Название команды", font: .markerFel14())
    let cityLabel = UILabel(text: "Место расположения", font: .markerFel14())
    let TypeTeamLabel = UILabel(text: "Тип команды:", font: .markerFel14())
    
    let nameTextField = CustomeTextField(placeholder: " ФК АвтоСпецЦентр")
    let cityTextField = CustomeTextField(placeholder: " Химки")
    
    let availabilityTeamSegmentedControl = UISegmentedControl(first: "Открытая", second: "Закрытая")
    
    let goToButton = UIButton(title: "Создать", titleColor: .white, backgroundColor: .buttonDark(), font: .bolt14(), cornerRadius: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
        goToButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
        fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension CreateTeamViewController {
    
    @objc private func plusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func goToChatsButtonTapped() {
        
        let mainContentFooTeam = UIHostingController(rootView: ContentFooTeamMenu())
        mainContentFooTeam.modalPresentationStyle = .fullScreen
        self.present(mainContentFooTeam, animated: true, completion: nil)
    }
    
}

// MARK: - Setup constraints
extension CreateTeamViewController {
    private func setupConstraints() {
        
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField], axis: .vertical, spacing: 5)
        
        let positionuStackView = UIStackView(arrangedSubviews: [cityLabel, cityTextField], axis: .vertical, spacing: 12)
        
        let whoAreYouStackView = UIStackView(arrangedSubviews: [TypeTeamLabel, availabilityTeamSegmentedControl], axis: .vertical, spacing: 12)
        
        goToButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [nameStackView, positionuStackView, whoAreYouStackView, goToButton], axis: .vertical, spacing: 20)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(fullImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate
extension CreateTeamViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        fullImageView.circleAvaTeamsImageView.image = image
    }
}
