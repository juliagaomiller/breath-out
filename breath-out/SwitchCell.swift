//
//  SwitchCell.swift
//  breath-out
//
//  Created by Julia Gao Miller on 2/13/17.
//  Copyright © 2017 Julia Gao Miller. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var switchButton: UISwitch!
    
    
    
    func backgroundChanged(mySwitch: UISwitch){
        if mySwitch.isOn {
            UserDefaults.standard.set(true, forKey: isBlackBackground)
        } else {
            UserDefaults.standard.set(false, forKey: isBlackBackground)
        }
        
    }
    
    func showTextChanged(mySwitch: UISwitch){
        if mySwitch.isOn {
            UserDefaults.standard.set(true, forKey: showText)
        } else {
            UserDefaults.standard.set(false, forKey: showText)
        }
    }
    
    func vibrateChanged(mySwitch: UISwitch){
        if mySwitch.isOn {
            UserDefaults.standard.set(true, forKey: vibrationOn)
        } else {
            UserDefaults.standard.set(false, forKey: vibrationOn)
        }
    }
    
    func musicChanged(mySwitch: UISwitch){
        if mySwitch.isOn {
            UserDefaults.standard.set(true, forKey: playMusic)
        } else {
            UserDefaults.standard.set(false, forKey: playMusic)
        }
    }

    
    func configure(type: Cell){
        switch(type){
        case .musicSwitch:
            switchButton.addTarget(self, action: #selector(musicChanged(mySwitch:)), for: .valueChanged)
            break
        case .backgroundColor:
            switchButton.addTarget(self, action: #selector(backgroundChanged(mySwitch:)), for: .valueChanged)
            break
        case .showText:
            switchButton.addTarget(self, action: #selector(showTextChanged(mySwitch:)), for: .valueChanged)
            break
        case .buzz:
            switchButton.addTarget(self, action: #selector(vibrateChanged(mySwitch:)), for: .valueChanged)
            break
        default:
            fatalError("this cell is not a SwitchCell \(type)")
        }
    }
    
}
