//
//  QuietTheRoarVC.swift
//  Roar-Admin
//
//  Created by Julia Gao Miller on 2/7/17.
//  Copyright © 2017 Julia Miller. All rights reserved.
//

import UIKit

let showText = "showText"
let isBlackBackground = "isBlackBackground"
let playMusic = "playMusic"
let vibrationOn = "vibrationOn"

class BoxBreathingVC: UIViewController {
    
    @IBOutlet var breathLabel: UILabel!
    @IBOutlet var glowOrb: UIImageView!
    
    let darkColor = UIColor.black
    let lightColor = UIColor.white
    
    var iterations = 0
    let iterationLimit = 2
    
    var nightMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        checkForUserDefaultChanges()
        
//        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
//        if launchedBefore  {
//            breathLabel.isHidden = true
//        } else {
//            breathLabel.isHidden = false
//            UserDefaults.standard.set(true, forKey: "launchedBefore")
//        }
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(switchMode))
//        self.view.addGestureRecognizer(tap)
        
        startAnimation()
        
    }
    
    func startAnimation(){
        //Circle starts small
        glowOrb.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        
        UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
            self.breathLabel.alpha = 1
        }) { (finished) in
            UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
                self.breathLabel.alpha = 0
            })
        }
        iterations += 1
        
        UIView.animate(withDuration: 4.0, delay: 1.0, animations: {
            self.glowOrb.transform = CGAffineTransform.identity
        }) { (finished) in
            self.contractCircle()
        }
    }
    
    func setUpView(){
        glowOrb.layer.cornerRadius = glowOrb.bounds.width / 2
        glowOrb.layer.masksToBounds = true
        
        breathLabel.textColor = UIColor.white
        breathLabel.alpha = 0
        breathLabel.text = "BREATH IN"
        self.view.backgroundColor = darkColor
    }
    
    func checkForUserDefaultChanges(){
        if let bool = UserDefaults.standard.value(forKey: isBlackBackground) != nil {
            setBackground(isDark: bool)
        } else {
            UserDefaults.standard.set(true, forKey: isBlackBackground)
        }
        if UserDefaults.standard.value(forKey: showText) != nil {
            
        } else {
            //set default
        }
        if UserDefaults.standard.value(forKey: vibrationOn) != nil {
            
        } else {
            //set default
        }
        if UserDefaults.standard.value(forKey: playMusic) != nil {
            
        } else {
            //set default
        }
    }
    
    func vibrateTwice(){
        
    }
    
    func vibrateOnce(){
        
    }
    
    func countToFour(){
        
    }
    
    func setBackground(isDark: Bool){
        if isDark {
            UIView.animate(withDuration: 4.0, animations: {
                self.view.backgroundColor = self.darkColor
            })
        } else {
            UIView.animate(withDuration: 4.0, animations: {
                self.view.backgroundColor = self.lightColor
            })
        }
        
    }
    
//    func switchMode(){
//        if nightMode {
//            UserDefaults.standard.set(true, forKey: "dayTime")
//            UIView.animate(withDuration: 4.0, animations: {
//                self.view.backgroundColor = self.lightColor
//            })
//        } else {
//            UserDefaults.standard.set(false, forKey: "dayTime")
//            UIView.animate(withDuration: 4.0, animations: {
//                self.view.backgroundColor = self.darkColor
//            })
//        }
//        nightMode = !nightMode
//    }
    
    func contractCircle(){
        if iterations <= iterationLimit {
            breathLabel.alpha = 0
            breathLabel.text = "HOLD"
            UIView.animate(withDuration: 1.5, animations: {
                self.breathLabel.alpha = 1
            }) {(finished) in
                UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
                    self.breathLabel.alpha = 0
                }) { (finished) in
                    self.breathLabel.text = "BREATH OUT"
                    UIView.animate(withDuration: 1.5, animations: {
                        self.breathLabel.alpha = 1
                    }) {(finished) in
                        UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
                            self.breathLabel.alpha = 0
                        })
                    }
                }
            }
        } else { breathLabel.isHidden = true}
        UIView.animate(withDuration: 4.0, delay: 4.0, options: .curveEaseInOut, animations: {
            self.glowOrb.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            self.breathLabel.alpha = 1
        }) { (finished) in
            self.breathLabel.alpha = 0
            self.expandCircle()
        }
    }
    
    func expandCircle(){
        breathLabel.alpha = 0
        if iterations <= iterationLimit {
            breathLabel.text = "HOLD"
            UIView.animate(withDuration: 1.5, animations: {
                self.breathLabel.alpha = 1
            }) {(finished) in
                UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
                    self.breathLabel.alpha = 0
                }) { (finished) in
                    self.breathLabel.text = "BREATH IN"
                    UIView.animate(withDuration: 1.5, animations: {
                        self.breathLabel.alpha = 1
                    }) {(finished) in
                        UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
                            self.breathLabel.alpha = 0
                        })
                    }
                }
            }
            iterations += 1
        } else { breathLabel.isHidden = true }
        UIView.animate(withDuration: 4.0, delay: 4.0, options: .curveEaseInOut, animations: {
            self.glowOrb.transform = CGAffineTransform.identity
            self.breathLabel.alpha = 1
        }) { (finished) in
            self.breathLabel.alpha = 0
            self.contractCircle()
        }
        
    }
    
    
}
