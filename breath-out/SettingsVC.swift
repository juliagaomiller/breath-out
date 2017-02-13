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
}


class SettingsVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var topToolbar: UIToolbar!
    
    var cellArray = [UITableViewCell]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        addShadowToTopToolbar()
        
        prepareTableViewCells()
        
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: id.rawValue)!
            cellArray.append(cell)
        }
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
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
    
}

extension SettingsVC {
    
}
