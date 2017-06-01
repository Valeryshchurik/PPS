//
//  ViewController.swift
//  PPS_7_9
//
//  Created by Admin on 30.05.17.
//  Copyright (c) 2017 Popov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var items = [Faculty]()
    var usedItem = Faculty()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = DBManager().getFacultys()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "facultySegue" {
            var vc: FacultyViewController = segue.destinationViewController as FacultyViewController
            vc.faculty = usedItem
        }
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("facultyCell") as UITableViewCell
        var item = items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "Address: " + item.address + "\nPhone: " + item.phone + "\nSite: " + item.site
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        usedItem = items[indexPath.row]
        performSegueWithIdentifier("facultySegue", sender: self)
    }
    
}


