//
//  SecondViewController.swift
//  ixLocation
//
//  Created by Grayson Wise on 6/5/17.
//  Copyright © 2017 Grayson Wise. All rights reserved.
//

import UIKit

class ActivityLogTableViewController: UITableViewController, AddActivityDelegate {

    var activities: [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let activity1 = Activity()
        activity1?.name = "First"
        activity1?.description = "First Activity"
        activities.append(activity1!)
        
        let activity2 = Activity()
        activity2?.name = "Second"
        activity2?.description = "Second Activity"
        activities.append(activity2!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
        cell.textLabel?.text = activities[indexPath.item].name
        cell.detailTextLabel?.text = activities[indexPath.item].description
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addActivity"){
            let activityWithCurrentLocation = Activity()
            let navigationController = segue.destination as! UINavigationController
            let addActivityViewController = navigationController.topViewController as! AddActivityViewController
            addActivityViewController.delegate = self
            addActivityViewController.newActivity = activityWithCurrentLocation
        }
        if segue.identifier == "navToActivityDetail"{
            let activityDetailViewController = segue.destination as! ActivityDetailViewController
            let cell = sender as! UITableViewCell
            let path = self.tableView.indexPath(for: cell)
            activityDetailViewController.activity = activities[(path?.row)!]
        }
    }
    
    func didSaveActivity(activity: Activity) {
        activities.append(activity)
    }
    
    func didCancelActivity() {
        
    }
}

