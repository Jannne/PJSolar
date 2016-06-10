//
//  ComparisonViewController.swift
//  PJDemo
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import Charts

class ComparisonViewController: UIViewController {
    
    
    var friendName : String?{
        didSet{
            redraw()
        }
    }
    
    func redraw(){
        labels[labels.endIndex-1] = friendName ?? "Friend"
    }
    
    @IBOutlet weak var radarChartView: RadarChartView!
    

    let dataPoints = ["GENERATION","CONSUMPTION","AIR CONDITIONER"]
    let values1 = [25.0, 14.0, 10]
    let values2 = [30.0, 20.0, 15]
    var labels = ["YOU", "FRIEND"]
    override func viewDidLoad() {
        super.viewDidLoad()

        radarChartView.innerWebColor = UIColor.lightGrayColor()
        radarChartView.innerWebLineWidth = 1.0
        drawMultiRadarChart(radarChartView, dataPoints: dataPoints, values: [values1, values2], labels: labels)
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
