//
//  CalendarFooTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class CalendarFooTeam {
    
    static let shared = CalendarFooTeam()
    
    private init() {}
    
    func timeFoot(_ timeLabel: UILabel) {
            let date = Date()
            let calendar = Calendar.current
            
            let weekday = calendar.component(.weekday, from: date)
            
            switch weekday {
            case 1:
                //            print("Сегодня Воскресенье")
                timeLabel.text = " через: 2 дня"
            case 2:
                //            print("Сегодня Понедельник")
                timeLabel.text = " через: день"
            case 3:
                //            print("Сегодня Вторник")
                timeLabel.text = " завтра"
            case 4:
                //            print("Сегодня Среда")
                timeLabel.text = " сегодня"
                timeLabel.textColor = .green
            case 5:
                //            print("Сегодня Четверг")
                timeLabel.text = " через: 5 дней"
    //            let players = self.players.filter("inTeam = true")
    //            players.forEach { player in
    //                try! realm.write {
    //                    let paymentInt = Int(player.payment)! - 1
    //                    player.payment = String(paymentInt)
    //                }
    //            }
            case 6:
                //            print("Сегодня Пятница")
                timeLabel.text = " через: 4 дня"
            case 7:
                //            print("Сегодня Суббота")
                timeLabel.text = " через: 3 дня"
            default:
                print("Error")
            }
        }
}
