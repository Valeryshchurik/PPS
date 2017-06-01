//
//  FacultyViewController.swift
//  PPS_7_9
//
//  Created by Admin on 31.05.17.
//  Copyright (c) 2017 Popov. All rights reserved.
//

import UIKit

class FacultyViewController: UIViewController {
    
    var faculty = Faculty()
    var usedItemSpec = Speciality()
    var usedItemCaf = Cafedra()
    
    @IBOutlet weak var headNameLabel: UILabel!
    @IBOutlet weak var tableSpeciality: UITableView!
    @IBOutlet weak var tableCafedra: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headNameLabel.text = faculty.head
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "specialitySegue" {
            var vc: SpecialityViewController = segue.destinationViewController as SpecialityViewController
            vc.speciality = usedItemSpec
        }
        else if segue.identifier == "cafedraSegue" {
            var vc: CafedraViewController = segue.destinationViewController as CafedraViewController
            vc.caf = usedItemCaf
        }
    }
}

extension FacultyViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableSpeciality {
            return self.faculty.specialities.count
        }
        else if tableView == tableCafedra {
            return self.faculty.cafedras.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == tableSpeciality {
            let cell = tableView.dequeueReusableCellWithIdentifier("specialityCell") as UITableViewCell
            var item = faculty.specialities[indexPath.row]
            
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "Form: " + item.form + "\nCafedra: " + item.cafedra
            return cell
        }
        else if tableView == tableCafedra {
            let cell = tableView.dequeueReusableCellWithIdentifier("cafedraCell") as UITableViewCell
            var item = faculty.cafedras[indexPath.row]
            
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "Address: " + item.address + "\nPhone: " + item.phone + "\nSite: " + item.site
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == tableSpeciality {
            usedItemSpec = faculty.specialities[indexPath.row]
            performSegueWithIdentifier("specialitySegue", sender: self)
        }
        else if tableView == tableCafedra {
            usedItemCaf = faculty.cafedras[indexPath.row]
            performSegueWithIdentifier("cafedraSegue", sender: self)
        }
    }
    
}
