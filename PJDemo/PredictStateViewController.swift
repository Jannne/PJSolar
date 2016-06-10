//
//  PredictStateViewController.swift
//  PJDemo
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class PredictStateViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text =
        
        "Using photovoltaic power generation system, historical data, solar irradiance data and meteorological data to establish multivariate polynomial regression model, and then build the prediction model to input the future temperature as input variables \n\n" +
        "       P = a + b * T * H + c * H + d * H^2 \n\n" +
            
       " Changes in solar irradiance are dynamic, multi-interference and other characteristics, which affect vital cloud cover, atmospheric conditions, weather conditions and other factors. Since the weather forecasting does not provide statistical methods of irradiance value forecasting needed for solar power generation prediction, but at the same type of weather, we can assume that the average daily effective solar irradiance are approximately equal.\n\n" +
        "Solar energy resource is one of the most abundant renewable energy sources, it is internationally recognized as the ideal replacement for conventional energy sources such as oil, gas, coal and other fossil-based energy. In short term, photovoltaic power generation can complement conventional energy, resolve residential electricity demand. From long term perspective, with distributed PV power getting into the electricity market, and replace part of conventional energy, it also has great significance in environmental protection and energy strategy. A number of companies has been rising to develop solar energy resources, meantime provide users real-time monitoring data of power generation efficiency applications."
        
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
