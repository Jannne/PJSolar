//
//  FetchWeatherData.swift
//  PJDemo
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation

class FetchWeatherData{
    
    var rainyData = [Double]()
    var rainyTemp = [Double]()
    var sunnyData = [Double]()
    var sunnyTemp = [Double]()
    var cloudyData = [Double]()
    var cloudyTemp = [Double]()
    var overcastData = [Double]()
    var overcastTemp = [Double]()
    
    func fetchWeatherInfo(){
        let innerQuery = PFQuery(className: "Weather")
        innerQuery.whereKeyExists("type")
        innerQuery.whereKeyExists("temperature")
        
        let query = PFQuery(className: "Display")
        query.whereKey("weather", matchesQuery: innerQuery)
        query.includeKey("weather")
        
        query.findObjectsInBackgroundWithBlock(){
            (objects, error) -> Void in
            if(error == nil){
                if let objects = objects{
                    for object in objects{
                        if let data = object["data"] as? Double{
                            if let weather = object["weather"] as? PFObject{
                                if let temperature = weather["temperature"] as? Double{
                                    if let type = weather["type"] as? String{
                                        switch type{
                                            case "sunny":
                                            self.sunnyData.append(data)
                                            self.sunnyTemp.append(temperature)
                                            case "rainy":
                                            self.rainyData.append(data)
                                            self.rainyTemp.append(temperature)
                                            case "cloudy":
                                            self.cloudyData.append(data)
                                            self.cloudyTemp.append(temperature)
                                            case "overcast":
                                            self.overcastData.append(data)
                                            self.overcastTemp.append(temperature)
                                        default:
                                            break
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
      
    }
}
