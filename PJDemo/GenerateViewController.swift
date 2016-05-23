//
//  GenerateViewController.swift
//  PJDemo
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import Charts

class GenerateViewController: UIViewController {
    
    @IBOutlet weak var substituteButton: UIButton!
    @IBOutlet weak var compareButton: UIButton!
    let daily = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
    
    let weekly = ["01","02","03","04","05","06","07"]
    
    let monthly = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27", "28","29","30"]
    
    let yearly = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    
    let unitsData_daily1 = [20.0, 4.0, 6.0, 3.0, 12.0, 1.0,2.0, 14.0, 3.0, 7.0, 9.0, 4.0,5.0, 2.0, 6.0, 13.0, 2.0,8.0,10.0, 14.0, 9.0, 3.0, 12.0, 16.0]
    
    var dailyData = [Double](){
        didSet{
           
        }
    }
    
    var weeklyData = [Double](){
        didSet{
            //redraw()
        }
    }
    var monthlyData = [Double](){
        didSet{
            //redraw()
        }
    }
    
    var yearlyData = [Double](){
        didSet{
            redraw()
        }
    }
    
    func redraw(){
       // barChartView.clear()
        //drawMultiBarCharts(barChartView, dataPoints: daily, values: [dailyData], labels: ["发电"])
       // print(yearlyData)
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0: drawBarCharts(barChartView, dataPoints: daily, values: dailyData)
        case 1: drawBarCharts(barChartView, dataPoints: weekly, values: weeklyData)
        case 2: drawBarCharts(barChartView, dataPoints: monthly, values: monthlyData)
        case 3: drawBarCharts(barChartView, dataPoints: yearly, values: yearlyData)
        default: break
        }
    }

    @IBOutlet weak var barChartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        drawBarCharts(barChartView, dataPoints: daily, values: dailyData)
        //drawMultiBarCharts(barChartView, dataPoints: daily, values: [dailyData],labels:["发电"])
        compareButton.layer.cornerRadius = 4
        substituteButton.layer.cornerRadius = 4
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
