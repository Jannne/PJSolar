//
//  PredictViewController.swift
//  PJDemo
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import Charts

class PredictViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var predictTableView: UITableView!
    @IBOutlet weak var predictChartView: LineChartView!
    
    let generatePowerTime = 13
    
    var temperaturePredict:[Weather] = []
    var dateArray : [String] = []
    
    var date = NSDate()
    let dateFormatter = NSDateFormatter()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    
    func getPredictPowerPerHour(type: Weather.WeatherType, temperature: Double)->Double
    {
        var predictPower : Double = 0.0;
        switch type
        {
        case .Sunny: predictPower = 33.49553 - 0.35350 * temperature;
        case .Cloudy : predictPower = 25.62699 - 0.26875 * temperature;
        case .Overcast : predictPower = 18.14406 - 0.19072 * temperature;
        case .Rainy : predictPower = 12.39479 - 0.13232 * temperature;
        default : break;
        }
        return predictPower
    }
    
    func getAllPredictPower(temparturePredict : [Weather])-> [Double]
    {
        var allPredictPower : [Double] = []
        for weather in temparturePredict
        {
            var power = getPredictPowerPerHour(weather.weatherType, temperature: weather.temperature)
            allPredictPower.append(power * 13)
        }
        return allPredictPower
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temperaturePredict.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = predictTableView.dequeueReusableCellWithIdentifier("predictCell", forIndexPath: indexPath) as! UITableViewCell
        let weather = temperaturePredict[indexPath.row]
        cell.textLabel?.text = dateArray[indexPath.row] + "      " + String(weather.weatherType) + "      " + String(weather.temperature)
        return cell
    }
    
    @IBAction func unwindToPredictScreen(segue: UIStoryboardSegue){
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI()
    {
        predictChartView.clear()
        let powerSet =  self.getAllPredictPower(self.temperaturePredict)
        drawLineCharts(self.predictChartView, dataPoints: dateArray, values: powerSet)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.predictChartView.backgroundColor = UIColor.whiteColor()
        self.predictChartView.gridBackgroundColor  = UIColor.whiteColor()
        
        dateFormatter.dateFormat = "MM/dd"
        for index in 1...5
        {
            var nextDate = date.dateByAddingTimeInterval(60*60*24*1)
            let stringForDate = dateFormatter.stringFromDate(nextDate)
            dateArray.append(stringForDate)
            date = nextDate
        }
        
        let weather = Weather(weatherType: .Cloudy, temperature: 25)
        temperaturePredict.append(weather)
        temperaturePredict.append(Weather(weatherType: .Sunny, temperature: 30.0))
        temperaturePredict.append(Weather(weatherType: .Rainy, temperature: 21.0))
        temperaturePredict.append(Weather(weatherType: .Overcast, temperature: 27.0))
        temperaturePredict.append(Weather(weatherType: .Sunny, temperature: 29.0))
        
//        let powerSet =  self.getAllPredictPower(self.temperaturePredict)
//        drawLineCharts(self.predictChartView, dataPoints: dateArray, values: powerSet)
        updateUI()
        predictTableView.delegate = self
        predictTableView.dataSource = self
        var weatherData = self.appDelegate.getWeatherData()
        
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
