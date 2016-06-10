//
//  SearchDateViewController.swift
//  SolarPower
//
//  Created by apple on 16/5/24.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class SearchDateViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!

    var date : String = ""
    @IBAction func didSearch(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYMMdd"
        date = dateFormatter.stringFromDate(datePicker.date)
        performSegueWithIdentifier("searchDate", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "searchDate"{
            let viewController = segue.destinationViewController as! DateResultViewController
            viewController.date = self.date
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            viewController.dateLabelText = dateFormatter.stringFromDate(datePicker.date)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
