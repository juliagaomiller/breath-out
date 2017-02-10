//
//  QuietTheRoarVC.swift
//  Roar-Admin
//
//  Created by Julia Gao Miller on 2/7/17.
//  Copyright © 2017 Julia Miller. All rights reserved.
//

import UIKit

class BoxBreathingVC: UIViewController {
    
    //PHOTOSHOP = MAKE APP ICON
    //ILLUSTRATOR = CREATE MY LOGO
    
    @IBOutlet var breathLabel: UILabel!
    @IBOutlet var glowOrb: UIImageView!
    
    let nightSky = UIColor(red:0.07, green:0.09, blue:0.32, alpha:1.0) //HEX: 1A2274
    let skyBlue = UIColor.white
    
    var iterations = 0
    let iterationLimit = 2
    
    var nightMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        glowOrb.layer.cornerRadius = glowOrb.bounds.width / 2
        
        breathLabel.textColor = UIColor.white
        breathLabel.alpha = 0
        breathLabel.text = "BREATH IN"
        self.view.backgroundColor = skyBlue
        
        if let dayTime = UserDefaults.standard.value(forKey: "dayTime") as? Bool{
            if dayTime { self.view.backgroundColor = skyBlue }
            else { self.view.backgroundColor = nightSky }
        } else {
            UserDefaults.standard.set(true, forKey: "dayTime")
        }
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            breathLabel.isHidden = true
        } else {
            breathLabel.isHidden = false
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(switchMode))
        self.view.addGestureRecognizer(tap)

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
    
    func switchMode(){
        if nightMode {
            UserDefaults.standard.set(true, forKey: "dayTime")
            UIView.animate(withDuration: 4.0, animations: {
                self.view.backgroundColor = self.skyBlue
            })
        } else {
            UserDefaults.standard.set(false, forKey: "dayTime")
            UIView.animate(withDuration: 4.0, animations: {
                self.view.backgroundColor = self.nightSky
            })
        }
        nightMode = !nightMode
    }
    
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
