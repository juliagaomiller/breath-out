//
//  SettingsVC.swift
//  breath-out
//
//  Created by Julia Gao Miller on 2/13/17.
//  Copyright © 2017 Julia Gao Miller. All rights reserved.
//

import UIKit

enum Cell: String {
    case about = "AboutCell"
    case aboutInfo = "AboutInfoCell"
    case backgroundColor = "BackgroundColorCell"
    case showText = "ShowTextCell"
    case buzz = "BuzzCell"
    case buzzInfo = "BuzzInfoCell"
    case musicSwitch = "MusicSwitchCell"
    case track = "TrackCell"
    case feedback = "FeedbackCell"
    case powLabs = "PowLabsCell"
    case timer = "TimerCell"
}

var timerMinutes = 0
var timerSeconds = 0


class SettingsVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var topToolbar: UIToolbar!
    @IBOutlet var timePickerView: UIView!
    @IBOutlet var pickerView: UIPickerView!
    
    var minutesArray = [Int]()
    
    var cellArray = [UITableViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillMinutesArray()
        
        timePickerView.isHidden = true
        pickerView.delegate = self
        pickerView.dataSource = self
        
        setUpTableView()
        addShadowToTopToolbar()
        prepareTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
       
    }
    
    func setUpTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.backgroundColor = UIColor.groupTableViewBackground
    }
    
    func addShadowToTopToolbar(){
        topToolbar.layer.masksToBounds = false
        topToolbar.layer.shadowColor = UIColor.darkGray.cgColor
        topToolbar.layer.shadowOpacity = 0.2
        topToolbar.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        topToolbar.layer.shadowRadius = 1.5
    }
    
    func prepareTableViewCells(){
        addCellToArray(withIdentifier: .about)
        addCellToArray(withIdentifier: .aboutInfo)
        addCellToArray(withIdentifier: .backgroundColor)
        addCellToArray(withIdentifier: .showText)
        addCellToArray(withIdentifier: .buzz)
        addCellToArray(withIdentifier: .buzzInfo)
        addCellToArray(withIdentifier: .timer)
//        addCellToArray(withIdentifier: .musicSwitch)
//        addCellToArray(withIdentifier: .track)
//        addCellToArray(withIdentifier: .feedback)
//        addCellToArray(withIdentifier: .powLabs)
        
        self.tableView.reloadData()
        
    }
    
    func addCellToArray(withIdentifier id: Cell){
        
        if id == .backgroundColor || id == .buzz || id == .showText {
            let cell = tableView.dequeueReusableCell(withIdentifier: id.rawValue) as! SwitchCell
            cell.configure(type: id)
            cellArray.append(cell)
        } else if id == .timer {
            let cell = tableView.dequeueReusableCell(withIdentifier: id.rawValue) as! TimerCell
            if timerMinutes != 0 {
                cell.label.text = "TIMER SET: \(timerMinutes) MIN"
            } else { cell.label.text = "SET TIMER" }
            cellArray.append(cell)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: id.rawValue)!
            cellArray.append(cell)
        }
    }
    
    func animatePickerView(){
        if timePickerView.isHidden {
            
        } else {
            
        }
    }
    
    @IBAction func cancel(){
        timerMinutes = 0
        timerSeconds = 0
                let cell = cellArray[6] as! TimerCell
        cell.label.text = "SET TIMER"
        cellArray[6] = cell
        
        timePickerView.isHidden = true
    }
    
    @IBAction func begin(){
        let cell = cellArray[6] as! TimerCell
        print(timerMinutes)
        cell.label.text = "TIMER SET: \(timerMinutes) MIN"
        cellArray[6] = cell
        timePickerView.isHidden = true
        tableView.reloadData()
    }
    
    func showPickerView(){
        timerMinutes = 1
        timePickerView.isHidden = false
//        print(timePickerView.isHidden)
        pickerView.reloadAllComponents()
        
        //and action to button
    }
    
    func fillMinutesArray() {
        var minute = 1
        while minute <= 60 {
            minutesArray.append(minute)
            minute += 1
        }
    }
    
    
    @IBAction func back(){
        print("timer seconds", timerSeconds)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SettingsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return minutesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "\(minutesArray[row]) minute"
        } else {
           return "\(minutesArray[row]) minutes"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timerMinutes = minutesArray[row]
//        print(timerMinutes)
        timerSeconds = timerMinutes * 60
        print("timer minutes", timerMinutes)
        print("timer seconds", timerSeconds)
    }
    
}

extension SettingsVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 6 {
            timerSeconds = 60
            showPickerView()
        }
    }
    
}

