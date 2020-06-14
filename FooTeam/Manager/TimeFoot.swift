//
//  TimeFoot.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class TimeFoot {
    
    private init() {}
    static let shared = TimeFoot()
    
    public func timeFoot(timeLabel: UILabel) {
        let date = Date()
        let calendar = Calendar.current
        
        let weekday = calendar.component(.weekday, from: date)
        
        switch weekday {
        case 1:
            print("Сегодня Воскресенье")
            timeLabel.text = "через: 3 дня"
        case 2:
            print("Сегодня Понедельник")
            timeLabel.text = "через: 2 дня"
        case 3:
            print("Сегодня Вторник")
            timeLabel.text = "через: 1 день"
        case 4:
            print("Сегодня Среда")
            timeLabel.text = ": завтра"
        case 5:
            print("Сегодня Четверг")
            timeLabel.text = ": сегодня"
            timeLabel.textColor = .red
        case 6:
            print("Сегодня Пятница")
            timeLabel.text = ": была вчера"
        case 7:
            print("Сегодня Суббота")
            timeLabel.text = "через: 4 дня"
        default:
            print("Error")
        }
    }
}
