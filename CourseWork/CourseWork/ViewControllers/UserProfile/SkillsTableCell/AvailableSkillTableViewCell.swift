//
//  AvailableSkillTableViewCell.swift
//  CourseWork
//
//  Created by Damir Zaripov on 05/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit

class AvailableSkillTableViewCell: UITableViewCell {

    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var spellNameLabel: UILabel!
    @IBOutlet weak var spellState: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var spellLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.levelView.layer.cornerRadius = 20
        self.containerView.layer.cornerRadius = 10
    }
    
    func config(with spell: Spell) {
        self.spellNameLabel.text = "Навык: \(spell.name)"
        
        if (spell.has) {
            self.spellState.text = "Статус: Навык получен"
        } else {
            self.spellState.text = "Статус: Навык еще не получен"
        }
        
        switch spell.level {
            case 1: self.levelView.backgroundColor = UIColor.red
            case 2: self.levelView.backgroundColor = UIColor.green
            case 3: self.levelView.backgroundColor = UIColor.yellow
        default:
            self.levelView.backgroundColor = UIColor.black
        }
        
        self.spellLevelLabel.text = "\(spell.level)"
    }
    
}
