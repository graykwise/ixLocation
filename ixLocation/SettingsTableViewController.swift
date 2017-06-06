//
//  SettingsViewController.swift
//  ixLocation
//
//  Created by Grayson Wise on 6/5/17.
//  Copyright © 2017 Grayson Wise. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let setName = UserDefaults.standard.string(forKey: "name")
        if(setName != nil){
            name.text = setName
        }
        else{
            name.text = "User"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && indexPath.row == 0 {
            self.tabBarController?.selectedIndex = 1
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            self.tabBarController?.selectedIndex = 0
        }
        
        if(indexPath.section == 2){
            tableView.cellForRow(at: IndexPath(row: 0, section: 2))?.accessoryType = .none
            tableView.cellForRow(at: IndexPath(row: 1, section: 2))?.accessoryType = .none
            tableView.cellForRow(at: IndexPath(row: 2, section: 2))?.accessoryType = .none
            
            if(indexPath.row == 0){
                UserDefaults.standard.set("hybrid", forKey: "mapKey")
                tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 2))?.accessoryType = .checkmark
            }
            if(indexPath.row == 1){
                UserDefaults.standard.set("satellite", forKey: "mapKey")
                tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 2))?.accessoryType = .checkmark
            }
            if(indexPath.row == 2){
                UserDefaults.standard.set("standard", forKey: "mapKey")
                tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 2))?.accessoryType = .checkmark
            }
        }
        
        
    }
    
    
    @IBAction func changePinColor(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0){
            print("red")
            UserDefaults.standard.set("red", forKey: "color")
        }
        if (sender.selectedSegmentIndex == 1){
            print("blue")
            UserDefaults.standard.set("blue", forKey: "color")
        }
        if (sender.selectedSegmentIndex == 2){
            print("green")
            UserDefaults.standard.set("green", forKey: "color")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
