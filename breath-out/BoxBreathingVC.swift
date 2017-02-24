//
//  QuietTheRoarVC.swift
//  Roar-Admin
//
//  Created by Julia Gao Miller on 2/7/17.
//  Copyright © 2017 Julia Miller. All rights reserved.
//

import UIKit
import AudioToolbox

let showText = "showText"
let isWhiteBackground = "isWhiteBackground"
let playMusic = "playMusic"
let vibrationOn = "vibrationOn"

class BoxBreathingVC: UIViewController {
    
    @IBOutlet var breathLabel: UILabel!
    @IBOutlet var glowOrb: UIImageView!
    @IBOutlet var timerLabel: UILabel!
    
    let darkColor = UIColor.black
    let lightColor = UIColor.white

    var vibrateOn = false
    var showTextOn = true
    var playMusicOn = false
    var timerOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
//        timerSeconds = 0
        
        timerLabel.isHidden = true
        
        setUpView()
        startAnimation()
        checkForUserDefaultChanges()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkForUserDefaultChanges()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        vibrateOn = false
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
////        print(timerSeconds)
////        if timerSeconds != 0 {
////            startTimer(seconds: timerSeconds)
////        }
//    }
    
    func startAnimation(){

        glowOrb.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        
        if showTextOn {
            self.breathLabel.text = "BREATHE IN"
            UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
                self.breathLabel.alpha = 1
            }) { (finished) in
                UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
                    self.breathLabel.alpha = 0
                })
            }
        }
        
        
        UIView.animate(withDuration: 4.0, delay: 1.0, animations: {

            if self.vibrateOn { self.vibrateOnce()}
            
            self.glowOrb.transform = CGAffineTransform.identity
        }) { (finished) in
            self.contractCircle()
        }
    }
    
    func startTimer(seconds: Int){
        timerLabel.isHidden = false
        let _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func convertSecondsToTime(seconds: Int)->String{
        if seconds > 59 {
            let minutes = seconds / 60
            let secondsLeft = seconds % 60
            if secondsLeft < 10 {
                return "\(minutes):0\(secondsLeft)"
            } else {
                return "\(minutes):\(secondsLeft)"
            }
            
        } else {
            return "0:\(seconds)"
        }
    }
    
    func sendAlert(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateTimer(){
        if timerSeconds > 0 {
            timerLabel.text = convertSecondsToTime(seconds: timerSeconds)
            timerSeconds -= 1
        } else {
            if timerOn {
                timerLabel.isHidden = true
                sendAlert(message: "Timer Done!")
                vibrateTwice()
                timerOn = false
            }
            
        }
    }
    
    func checkForUserDefaultChanges(){
        
        if timerSeconds != 0 {
            timerOn = true
        } else {timerOn = false}
    
        setBackground(isWhite: UserDefaults.standard.bool(forKey: isWhiteBackground))
        showTextOn = UserDefaults.standard.bool(forKey: showText)
        vibrateOn = UserDefaults.standard.bool(forKey: vibrationOn)
        playMusicOn = UserDefaults.standard.bool(forKey: playMusic)
    }
    
    func contractCircle(){
//        print(timerSeconds)
        if timerOn {
            startTimer(seconds: timerSeconds)
        }
//        if timerSeconds != 0 {
//            
//        }
//        
        if showTextOn {
          animateBreathLabel(breathText: "BREATHE OUT")
        }
        
        performVibrations(on: vibrateOn)
        
        UIView.animate(withDuration: 4.0, delay: 4.0, options: .curveEaseInOut, animations: {
            self.glowOrb.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        }) { (finished) in
            self.expandCircle()
        }
    }
    
    
    
    func expandCircle(){
        if timerOn {
            startTimer(seconds: timerSeconds)
        }
//        if timerSeconds != 0 {
//            startTimer(seconds: timerSeconds)
//        }
        
        if showTextOn {
            animateBreathLabel(breathText: "BREATHE IN")
        }
        
        performVibrations(on: vibrateOn)
        
        UIView.animate(withDuration: 4.0, delay: 4.0, options: .curveEaseInOut, animations: {
            self.glowOrb.transform = CGAffineTransform.identity
        }) { (finished) in
            self.contractCircle()
        }
        
    }
    
    func performVibrations(on: Bool){
        if on {
            vibrateOnce()
//            let _ = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(vibrateTwice), userInfo: nil, repeats: false)
        }
        
    }
    
    func vibrateTwice(){
        vibrateOnce()
        let _ = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(vibrateOnce), userInfo: nil, repeats: false)
    }
    
    func vibrateOnce(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    func setBackground(isWhite: Bool){
        if isWhite {
            UIView.animate(withDuration: 2.0, animations: {
                self.view.backgroundColor = self.lightColor
            })
            
        } else {
            UIView.animate(withDuration: 2.0, animations: {
                self.view.backgroundColor = self.darkColor
                
            })
        }

    }
    
    func animateBreathLabel(breathText: String){
        breathLabel.alpha = 0
        breathLabel.text = "HOLD"
        UIView.animate(withDuration: 1.5, animations: {
            self.breathLabel.alpha = 1
        }) {(finished) in
            UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
                self.breathLabel.alpha = 0
            }) { (finished) in
                self.breathLabel.text = breathText
                UIView.animate(withDuration: 1.5, animations: {
                    self.breathLabel.alpha = 1
                }) {(finished) in
                    UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
                        self.breathLabel.alpha = 0
                    })
                }
            }
        }
    }
    
    func setUpView(){
        glowOrb.layer.cornerRadius = glowOrb.bounds.width / 2
        glowOrb.layer.masksToBounds = true
        
        breathLabel.textColor = UIColor.white
        breathLabel.alpha = 0
        
    }
    
}
