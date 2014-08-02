//
//  MessengerTableViewController.swift
//  MessengerPrototype
//
//  Created by Anthony Giugno on 2014-07-19.
//  Copyright (c) 2014 Anthony Giugno. All rights reserved.
//

import UIKit

class MessengerTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UITextFieldDelegate, MessengerTableViewControllerDelegate {

    var friends = String[]()
    var profileImages = String[]()
    
    var preferredWidth = CGFloat()
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friends = ["Hey Dude!", "How are you?", "Been doing good, just been coding and playing alot of dota..", "Ah well that sounds like fun.", "Yup", "asda", "dasd", "addad", "sup", "dasdadad", "dasdfas", "dsad a dasdadada d", "dasd asd ad a da d"]
        //profileImages = ["ballmer", "checkmark", "OrangeSplashScreen", "twittericon", "OrangeSplashScreen2"]
        
        self.tableView.separatorColor = UIColor.clearColor()
        
        self.refreshControl.beginRefreshing()
        self.refreshControl.endRefreshing()
        self.refreshControl.setNeedsLayout()
        
        self.tableView.reloadData()

        self.messengerScrollToBottom(firstTimeOccurring: true)
        
        self.refreshControl.addTarget(self, action:Selector("didRefreshTable"), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.keyboardDismissMode  =  UIScrollViewKeyboardDismissMode.OnDrag //change to interactive when inputAccessoryView is added.
    }

    
/*    override func scrollViewDidScroll(scrollView: UIScrollView!) {
        
    } */

    
    func didRefreshTable() {
        //self.friends.append("fsfds")
        //self.profileImages.append("ballmer")
        self.tableView.reloadData() //Just execute the data source functions again to verify it they match model. More useful when the app has a backend.
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        self.refreshControl.attributedTitle = NSAttributedString(string: "Last Updated: " + formatter.stringFromDate((date)))
        self.refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return friends.count
    }
    
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell = tableView!.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as MessageTableViewCell
        //let cell2 = tableView!.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as MessageTableViewCell
        //cell.messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //cell.messageLabel.numberOfLines = 0
        
        /*if (indexPath!.row == 2) {
            cell = tableView!.dequeueReusableCellWithIdentifier("Cell2")
        } */
        
        if UIApplication.sharedApplication().statusBarOrientation.isLandscape == true {
            cell.messageLabel.preferredMaxLayoutWidth = cell.frame.size.width - 80
        } else {
            cell.messageLabel.preferredMaxLayoutWidth = cell.frame.size.width - 35
        }

        preferredWidth = cell.messageLabel.preferredMaxLayoutWidth
        
        cell.messageLabel.text = friends[indexPath!.row]
        cell.messageLabel.sizeToFit()
        cell.messageLabel.setNeedsDisplay()
        
        //cell.msgBubble.layer.masksToBounds = true
        //cell.msgBubble.layer.cornerRadius = 10.0
        
        //--
        //cell.messageLabel.backgroundColor = UIColor(red: 125/255, green: 120/255, blue: 150/255, alpha: 0.5)
        
        //cell.msgBubble.frame = cell.messageLabel.frame
        //cell.msgBubble.setNeedsDisplay()
        
        return cell
    }

    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        var sampleLabel = UILabel()
        sampleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        sampleLabel.numberOfLines = 0
        sampleLabel.preferredMaxLayoutWidth = preferredWidth
        
        sampleLabel.text = friends[indexPath!.row]
        sampleLabel.sizeToFit()
        sampleLabel.setNeedsDisplay()
        
        return sampleLabel.intrinsicContentSize().height + 16

    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval)
    {
        self.tableView.reloadData()
    }
    
    func messengerScrollToBottom(firstTimeOccurring firstTime : Bool) {
        //self.tableView.scrollToNearestSelectedRowAtScrollPosition(UITableViewScrollPosition.Bottom, animated: true)
        //self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: friends.count, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        
        
        if firstTime == true {
            self.tableView.setContentOffset(CGPointMake(0, CGFLOAT_MAX), animated: true)
        } else {
        self.tableView.setContentOffset(CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height), animated: true)
        }

    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    
    // Override to support editing the table view.
    /*
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //indexPath!.delete(indexPath!.row)
            friends.removeAtIndex(indexPath!.row) //remove the item(s) from the model (in this case, the friends/profileImages array.)
            profileImages.removeAtIndex(indexPath!.row)
            tableView!.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade) //animate the removal of the element on tableView.
        } else if editingStyle == .Insert {
            //tableView!.insertRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Right)
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */
    //performsegue is used to jump from one viewcontroller to another when they are in separate locations of the app.
    
    // #pragma mark - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController ].
    
        }
    // Pass the selected object to the new view controller.
    }
    */

}

protocol MessengerTableViewControllerDelegate {
    func messengerScrollToBottom(firstTimeOccurring firstTime : Bool)
}
