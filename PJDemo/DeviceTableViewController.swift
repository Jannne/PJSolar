//
//  DeviceTableViewController.swift
//  PJDemo
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class DeviceTableViewController: UITableViewController{

    var parseObject : PFObject?
    let deviceTable = ["Building Comsumption","Photovoltaic Generation","Building Efficiency","Search By Date"]
    
    let generateData = FetchGenerateData()
    let consumeData = FetchConsumeData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateData.callPFObjectQueryGenDaily()
        generateData.callPFObjectQueryGenWeekly()
        generateData.callPFObjectQueryGenMonthly()
        generateData.callPFObjectQueryGenYearly()
        
        consumeData.callPFObjectQueryConDaily()
        consumeData.callPFObjectQueryConWeekly()
        consumeData.callPFObjectQueryConMonthly()
        consumeData.callPFObjectQueryConYearly()
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return deviceTable.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DataTableViewCell
        /*if let pfObject = object{
            cell?.textLabel?.text = pfObject["name"] as? String
        }*/
        cell.titleLabel.text = deviceTable[indexPath.row]
        
        switch indexPath.row{
        case 0: cell.bkImageView.image = UIImage(named: "Home1")
        case 1: cell.bkImageView.image =  UIImage(named: "Solar1")
        case 2: cell.bkImageView.image =  UIImage(named: "Composition1")
        case 3: cell.bkImageView.image = UIImage(named: "Date")
        default:break
        }
        
        
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let indexPath = tableView.indexPathForSelectedRow
        //tableView.reloadData()
        if((indexPath) != nil){
            tableView.deselectRowAtIndexPath(indexPath!, animated: true)
        }
    }
    
   
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //tableView(tableView, didDeselectRowAtIndexPath: indexPath.row)
        
        switch indexPath.row{
            
        case 0: self.performSegueWithIdentifier("consumeSegue", sender: self);
        
        break;
        case 1: self.performSegueWithIdentifier("generateSegue", sender: self);
        break;
        case 2: self.performSegueWithIdentifier("efficientSegue", sender: self);
        break;
        case 3: self.performSegueWithIdentifier("search", sender: self)
        default:
            break
        }    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "generateSegue"){
            let viewController = segue.destinationViewController as? GenerateViewController
            viewController?.dailyData = generateData.dailyData
            viewController?.weeklyData = generateData.weeklyData
            viewController?.monthlyData = generateData.monthlyData
            viewController?.yearlyData = generateData.yearlyData
            //presentViewController(viewController!, animated: true, completion: nil)
        }
        if(segue.identifier == "consumeSegue"){
            let viewController = segue.destinationViewController as? ConsumeViewController
            viewController?.dailyData = consumeData.dailyData
            viewController?.weeklyData = consumeData.weeklyData
            viewController?.monthlyData = consumeData.monthlyData
            viewController?.yearlyData = consumeData.yearlyData
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
