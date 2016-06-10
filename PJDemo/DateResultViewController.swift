//
//  DateResultViewController.swift
//  SolarPower
//
//  Created by apple on 16/5/24.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import Charts

class DateResultViewController: UIViewController {
    @IBOutlet weak var barChartView: BarChartView!
    
    
    @IBOutlet weak var consumeBarChart: BarChartView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    let daily = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
    var date : String = ""{
        didSet{
            
        }
    }
    var dateLabelText : String = ""{
        didSet{
            //dateLabel.text = dateLabelText
        }
    }
    var generateData = [Double]()
    var consumeData = [Double]()
    
    func searchResult(){
        let query = PFQuery(className: "GenerateData")
        let genData_Id = (PFUser.currentUser()!["genData_Id"] as? String) ?? ""
        
        query.whereKey("genData_Id", equalTo: genData_Id)
        query.whereKey("time", hasPrefix: date)
        query.orderByAscending("time")
        if let objects = query.findObjects() as? [PFObject]{
            if objects.count > 0{
                for object in objects{
                    if let value = object["data"] as? Double{
                        generateData.append(value)
                    }
                }
            }
            // PFObject.pinAllInBackground(<#T##objects: [AnyObject]?##[AnyObject]?#>)
        }
        while(generateData.count < 24){
            generateData.append(Double(0))
            
        }
        
        let consumeQuery = PFQuery(className: "ConsumeData")
        let conData_Id = (PFUser.currentUser()!["conData_Id"] as? String) ?? ""
        consumeQuery.whereKey("conData_Id", equalTo: conData_Id)
        consumeQuery.whereKey("time", hasPrefix: date)
        consumeQuery.orderByAscending("time")
        if let consumeObjects = consumeQuery.findObjects() as? [PFObject]{
            if consumeObjects.count > 0{
                for object in consumeObjects{
                    if let value = object["data"] as? Double{
                        consumeData.append(value)
                    }
                }
            }
        }
        while(consumeData.count < 24){
            consumeData.append(Double(0))
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = dateLabelText
        searchResult()
       // drawMultiBarCharts(barChartView, dataPoints: daily, values: [generateData,consumeData], labels: ["Generation","Consumption"])
        drawBarCharts(barChartView, dataPoints: daily, values: generateData, labelText: "Generation")
        drawBarCharts(consumeBarChart, dataPoints: daily, values: consumeData, labelText: "Consumption")
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
