//
//  SpecialityViewController.swift
//  PPS_7_9
//
//  Created by Admin on 01.06.17.
//  Copyright (c) 2017 Popov. All rights reserved.
//

import UIKit

class SpecialityViewController: UIViewController {

    var speciality: Speciality!
    
    @IBOutlet weak var tableGrade: UITableView!
    @IBOutlet weak var tablePlan: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SpecialityViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableGrade {
            return self.speciality.grades.count
        }
        else if tableView == tablePlan {
            return self.speciality.plans.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == tableGrade {
            let cell = tableView.dequeueReusableCellWithIdentifier("gradeCell") as UITableViewCell
            let row = speciality.grades.keys.array[indexPath.row]
            var item = speciality.grades[row]!
            
            cell.textLabel?.text = String(row);
            for it in item {
                cell.detailTextLabel?.text = it.subj + " - " + String(it.grade) + "\n"
            }
            return cell
        }
        else if tableView == tablePlan {
            let cell = tableView.dequeueReusableCellWithIdentifier("planCell") as UITableViewCell
            let row = speciality.plans.keys.array[indexPath.row]
            var item = speciality.plans[row]!
            
            cell.textLabel?.text = String(row);
            cell.detailTextLabel?.text = "Free: " + String(item.free) + "\nUnfree: " + String(item.unfree)
            return cell

        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}

