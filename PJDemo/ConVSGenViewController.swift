//
//  ConVSGenViewController.swift
//  PJDemo
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import Charts

class ConVSGenViewController: UIViewController {

    let genDaily : [Double] = [0, 0, 0, 0, 1, 2, 4, 5, 7.6, 10.4, 10.5, 9.8, 7.8, 4.9, 3.9, 2.0, 1.0, 0, 0, 0, 0, 0, 0, 0]
    let conDaily : [Double] = [1.0, 1.0, 1.0, 1.0, 2.3, 3.0 ,5.5, 7.0, 9.5, 11.0, 12.5, 10.4, 9.5, 6.5, 4.7, 5.0, 8.9, 9.8, 11.2, 12.5,10.5,7.9, 5.0,3.0]
    let daily = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
    
    let monthly = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27", "28", "29","30"]
    
    let conMonthly = [120.0, 400.0, 260.0, 133.0, 152.0, 196.0, 200.4, 165.8, 170.5, 156.5, 149.8, 160.8, 178.9, 200.2, 210.5,120.0, 400.0, 260.0, 133.0, 152.0, 196.0, 200.4, 165.8, 170.5, 156.5, 149.8, 160.8, 178.9, 200.2, 210.5]
    let genMonthly = [100.0, 250.0, 160.0, 190.0, 200.0, 215.3, 187.4, 195.8, 210.5, 156.9, 179.8, 200.5, 234.7, 179.9, 204.1,100.0, 250.0, 160.0, 190.0, 200.0, 215.3, 187.4, 195.8, 210.5, 156.9, 179.8, 200.5, 234.7, 179.9, 204.1]
    
    let yearly = ["Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    let conYearly = [1200.0, 1400.0, 2610.0, 1343.0, 1562.0, 1976.0, 1583.0, 1434.0,2870.0,1790.0, 2000.0,1980.0]
    let genYearly = [1569.8, 1673.2, 1875.4, 1987.9, 2003.4, 2045.6, 2300.4, 1996.5, 1897.5, 2014.5,2405.6, 2500.4]
    
    
    
    @IBAction func indexChanged(sender: AnyObject) {
        
        switch sender.selectedSegmentIndex{
        case 0:  drawMultiLineCharts(barChartView,dataPoints: daily, values: [conDaily,genDaily], labels: ["Consumption","Generation"])
            
        case 1:
            drawMultiLineCharts(barChartView,dataPoints: monthly, values: [conMonthly,genMonthly], labels: ["Consumption","Generation"])
            
        case 2 :
           drawMultiLineCharts(barChartView, dataPoints: yearly, values: [conYearly,genYearly],labels: ["Consumption","Generation"])
            
        default : break
        }
    }
    @IBOutlet weak var barChartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        drawMultiLineCharts(barChartView,dataPoints: daily, values: [conDaily,genDaily], labels: ["Consumption","Generation"])
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
