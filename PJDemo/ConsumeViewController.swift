//
//  ChartsViewController.swift
//  PJDemo
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import Charts

class ConsumeViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
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
            //redraw()
        }
    }
    
    
    @IBOutlet weak var furnitureSwitch: UISwitch!
    
    let currentDate = NSDate()
    let dateFormatter = NSDateFormatter()
    
    
    
    
    var daily = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
    
    let unitsData_daily1 = [20.0, 4.0, 6.0, 3.0, 12.0, 1.0,2.0, 14.0, 3.0, 7.0, 9.0, 4.0,5.0, 2.0, 6.0, 13.0, 2.0,8.0,10.0, 14.0, 9.0, 3.0, 12.0, 16.0]
    let unitsData_daily2 = [4.0, 2.0, 3.0, 3.0, 6.0, 8.0,10.0, 4.0, 6.0, 3.0, 5.0, 6.0,10.0, 4.0, 6.0, 3.0, 12.0, 16.0,20.0, 4.0, 3.0, 3.0, 6.0, 2.0]
    
    let weekly = ["Mon.","Tue.","Wed.","Thu","Fri","Sat.","Sun."]
    
    let unitsData_weekly = [50.0,70.0,30.0,40.0,60.0,89.0,78.0]
    
    let monthly = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27", "28", "29","30"]
    let unitsSold_monthly = [120.0, 400.0, 260.0, 133.0, 152.0, 196.0, 200.4, 165.8, 170.5, 156.5, 149.8, 160.8, 178.9, 200.2, 210.5,120.0, 400.0, 260.0, 133.0, 152.0, 196.0, 200.4, 165.8, 170.5, 156.5, 149.8, 160.8, 178.9, 200.2, 210.5]
    
    let yearly = ["Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    let unitsSold_yearly = [1200.0, 1400.0, 2610.0, 1343.0, 1562.0, 1976.0, 1583.0, 1434.0,2870.0,1790.0, 2000.0,1980.0]
    
    var currentIndex = 0
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        dateFormatter.dateFormat = "HH"
        
        switch sender.selectedSegmentIndex{
        case 0: setChart(daily, values: unitsData_daily1,label: "Daily Consumption")
         
        case 1:
            setChart(weekly, values: unitsData_weekly, label : "Weekly Consumption")
            
        case 2 : setChart(monthly , values: unitsSold_monthly , label : "Monthly Consumption")
  
        case 3: setChart(yearly, values: unitsSold_yearly, label: "Yearly Consumption")
    
        default : break
            
            
        }
    }
    func setChart(dataPoints : [String],values: [Double],label: String){
        lineChartView.fitScreen()
        if(dataPoints.count != values.count){
            return
        }
        var dataEntries : [ChartDataEntry] = []
        for i in 0 ..< dataPoints.count{
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
    
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: label)
        setChartLineData(lineChartDataSet, color: UIColor.darkGrayColor())
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartData.setValueTextColor(UIColor.darkGrayColor())
        lineChartView.data = lineChartData
        lineChartView.animate(xAxisDuration: 1.0, easingOption: ChartEasingOption.Linear)
    }
    func setChartDailySet(dataPoints:[String])
    {
        var dataEntries: [ChartDataEntry] = []
        for i in 0 ..< dataPoints.count{
            let dataEntry = ChartDataEntry(value: unitsData_daily1[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let set1: LineChartDataSet = LineChartDataSet(yVals:dataEntries,label:"1st")
        setChartLineData(set1, color: UIColor.whiteColor())
        
        
        var dataEntries2: [ChartDataEntry] = []
        for i in 0 ..< dataPoints.count{
            let dataEntry = ChartDataEntry(value: unitsData_daily2[i], xIndex: i)
            dataEntries2.append(dataEntry)
        }
        let set2: LineChartDataSet = LineChartDataSet(yVals:dataEntries2,label:"2nd")
        setChartLineData(set2, color: UIColor.redColor())
        
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        dataSets.append(set2)
        
        let data: LineChartData = LineChartData(xVals: dataPoints, dataSets: dataSets)
        data.setValueTextColor(UIColor.whiteColor())
        
        //5 - finally set our data
        
        lineChartView.data = data
    }
    func setChartLineData(set: LineChartDataSet, color: UIColor)
    {
        let lineColor = color.colorWithAlphaComponent(0.5)
        set.setColor(lineColor)
        set.setCircleColor(color)
        set.lineWidth = 2.0
        set.circleRadius = 4.0
        set.fillAlpha = 65 / 255.0
        set.fillColor = color
        set.highlightColor = UIColor.whiteColor()
        set.drawCircleHoleEnabled = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lineChartView.delegate = self
 
        self.lineChartView.leftAxis.labelPosition = .OutsideChart

        self.lineChartView.descriptionText = ""
        
        setChart(daily, values: unitsData_daily1, label : "Daily Consumption")
        
//        totalSwitch.addTarget(self, action: Selector("switchIsChanged:"), forControlEvents: UIControlEvents.ValueChanged)

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
