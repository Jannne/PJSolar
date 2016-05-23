//
//  FirstViewController.swift
//  PJDemo
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import Charts

class GrossViewController: UIViewController,SpinningViewDataSource ,CLLocationManagerDelegate{

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var temperatureImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    
    let date = NSDate()
    let dateFormatter = NSDateFormatter()
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var spinningView: SpinningView!{
        didSet{
            spinningView.dataSource = self
        }
    }
    @IBOutlet weak var percentLabel: UILabel!
   
    @IBOutlet weak var ConvsGenBarChartView: BarChartView!
    
    
    let consume = ["夏季空调","冬季采暖","其他"]
    let consume_value = [150.0 , 400.0 , 100.0]
    
    let consume_v_generate = ["1","2","3","4","5","6","7"]
    let consume_data = [3.0 , 6.6 , 7.9 , 4.7 , 9.7 , 3.6 , 2.0]
    let generate_value = [2.5 , 6.9, 4.1, 10.0 , 3.9, 9.0 , 5.0 ]
    
    var percentage : Double = 0.0{
        didSet{
            percentage = min(max(percentage,0),1)
            updateUI()
            
        }
    }
    func updateUI(){
        
        
        //spinningView.setup()
        
        
        spinningView.updateAnimation()
        
        self.ConvsGenBarChartView.descriptionText = ""
        self.ConvsGenBarChartView.xAxis.labelPosition = .Bottom
        self.ConvsGenBarChartView.leftAxis.labelPosition = .OutsideChart
        // self.ConvsGenBarChartView.backgroundColor = UIColor.whiteColor()
        self.ConvsGenBarChartView.gridBackgroundColor = UIColor.whiteColor()
        drawMultiBarCharts(ConvsGenBarChartView, dataPoints: consume_v_generate, values: [consume_data,generate_value], labels: ["耗电","发电"])
        
        percentLabel.text = "75%"
        temperatureLabel.text = "27"
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateLabel.text = dateFormatter.stringFromDate(date)

    }
    
    func percentForSpinningView(sender: SpinningView) -> Double? {
        return Double(percentage)
    }
    
    func getUserLocation(){
        //ask for authorization from user
        self.locationManager.requestAlwaysAuthorization()
        //for use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue : CLLocationCoordinate2D = (manager.location?.coordinate)!
        print("\(locValue.latitude) \(locValue.longitude)")
    }
    
    override func viewWillAppear(animated: Bool) {
        if(PFUser.currentUser() == nil){
            dispatch_async(dispatch_get_main_queue()){ () -> Void in
                let viewController : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") 
                self.presentViewController(viewController, animated: true, completion: nil)
                
            }
        }
        percentage = 0.5
        updateUI()
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

