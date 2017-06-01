//
//  CafedraViewController.swift
//  PPS_7_9
//
//  Created by Admin on 01.06.17.
//  Copyright (c) 2017 Popov. All rights reserved.
//

import UIKit

class CafedraViewController: UIViewController {

    var caf = Cafedra()
    var usedItem = Speciality()
    
    @IBOutlet weak var cafHeadNameLabel: UILabel!
    @IBOutlet weak var tableCafedra: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cafHeadNameLabel.text = caf.head
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cafedraSpecialitySegue" {
            var vc: SpecialityViewController = segue.destinationViewController as SpecialityViewController
            vc.speciality = usedItem
        }
    }
}

extension CafedraViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caf.specialities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("speccafedraCell") as UITableViewCell
        var item = caf.specialities[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "Form: " + item.form
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        usedItem = caf.specialities[indexPath.row]
        performSegueWithIdentifier("cafedraSpecialitySegue", sender: self)
    }
}


