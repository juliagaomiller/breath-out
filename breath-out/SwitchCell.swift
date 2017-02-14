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
        print("background changed")
        if mySwitch.isOn {
            UserDefaults.standard.set(false, forKey: isWhiteBackground)
            label.text = "Dark Mode"
        } else {
            UserDefaults.standard.set(true, forKey: isWhiteBackground)
            label.text = "Light Mode"
        }
        
    }
    
    func showTextChanged(mySwitch: UISwitch){
        if mySwitch.isOn {
            UserDefaults.standard.set(true, forKey: showText)
//            label.text = "SHOW TEXT: ON"
        } else {
            UserDefaults.standard.set(false, forKey: showText)
//            label.text = "SHOW TEXT: OFF"
        }
    }
    
    func vibrateChanged(mySwitch: UISwitch){
        if mySwitch.isOn {
            UserDefaults.standard.set(true, forKey: vibrationOn)
//            label.text = "VIBRATION MODE: ON"
        } else {
            UserDefaults.standard.set(false, forKey: vibrationOn)
//            label.text = "VIBRATION MODE: OFF"
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
            let isBlack = !(UserDefaults.standard.bool(forKey: isWhiteBackground))
            switchButton.setOn(isBlack, animated: false)
            label.text = (isBlack) ? "Dark Mode" : "Light Mode"
        case .showText:
            switchButton.addTarget(self, action: #selector(showTextChanged(mySwitch:)), for: .valueChanged)
            let showTextOn = UserDefaults.standard.bool(forKey: showText)
            switchButton.setOn(showTextOn, animated: false)
            label.text = "Show Text"
//            label.text = (showTextOn) ? "SHOW TEXT: ON" : "SHOW TEXT: OFF"
            break
        case .buzz:
            switchButton.addTarget(self, action: #selector(vibrateChanged(mySwitch:)), for: .valueChanged)
            let vibrateOn = (UserDefaults.standard.bool(forKey: vibrationOn))
            switchButton.setOn(vibrateOn, animated: false)
            label.text = "Vibration Mode"
//            label.text = (vibrateOn) ? "VIBRATION MODE: ON" : "VIBRATION MODE: OFF"

            break
        default:
            fatalError("this cell is not a SwitchCell \(type)")
        }
    }
    
}
