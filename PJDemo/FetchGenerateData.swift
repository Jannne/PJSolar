//
//  FetchGenerateData.swift
//  PJDemo
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
import UIKit

class FetchGenerateData{
    var date = NSDate()
    var dateFormatter = NSDateFormatter()
    
    var dailyData = [Double]()
    var weeklyData : [Double] = [0,0,0,0,0,0,0]
    var monthlyData = [Double]()
    var yearlyData = [Double]()
    
    
    
    //获取一天数据(小时)，如果尚未有数据，则置为0
    func callPFObjectQueryGenDaily() {
        
        
        let genData_Id = (PFUser.currentUser()!["genData_Id"] as? String) ?? ""
        
        let query = PFQuery(className: "GenerateData")
        query.whereKey("genData_Id", equalTo: genData_Id)
        
        //get current date
        
        dateFormatter.dateFormat = "YYMMdd"
        let dateDescrip = dateFormatter.stringFromDate(date)
        
        query.whereKey("time", containsString: dateDescrip)
        query.orderByAscending("time")
      
        query.findObjectsInBackgroundWithBlock{
            (objects, error) -> Void in
            if error == nil{
                if let objects = objects{
                    var count = 0
                    for object in objects{
                        if let data = object.objectForKey("data") as? Double{
                            //print(data)
                            self.dailyData.append(data)
                            count += 1
                        }
                    }
                    while(count < 24){
                        self.dailyData.append(Double(0.0))
                        count += 1
                    }
                    
                }
            }else{
                NSLog("ERROR : ", (error?.userInfo)!)
            }
        }
    }
    
    func getWeekDate(date: NSDate)->[String]{
        dateFormatter.dateFormat = "YYMMdd"
        let currDate = dateFormatter.stringFromDate(date)
        var dateArray = [String]()
        
        var dateToAdd = date
        dateArray.append(currDate)
        for index in 1...6{
            let prevDate = dateToAdd.dateByAddingTimeInterval(-60*60*24*1)
            let prevDateString = dateFormatter.stringFromDate(prevDate)
            
            dateArray.insert(prevDateString, atIndex: 0)
            dateToAdd = prevDate
        }
        return dateArray
    }
    
    func callPFObjectQueryGenWeekly(){
        let genData_Id = (PFUser.currentUser()!["genData_Id"] as? String) ?? ""
        let dateArray = getWeekDate(date)
        let count = dateArray.count
        
        for index in 1...count{
            
        
        var query = PFQuery(className: "GenerateData")
        query.whereKey("genData_Id", equalTo: genData_Id)
        
        query.whereKey("time", containsString: dateArray[index-1])
            
        query.findObjectsInBackgroundWithBlock{
            (objects, error) -> Void in
            if error == nil{
                if let objects = objects{
                    var sum : Double = 0
                    for object in objects{
                        if let data = object.objectForKey("data") as? Double{
                            //print(data)
                           sum += data

                        }
                    }
                self.weeklyData[index-1] = sum
                
                }
            }else{
                NSLog("ERROR : ", (error?.userInfo)!)
            }
        }
    }
}
    func getMonthDate(date: NSDate)->[String]{
        dateFormatter.dateFormat = "YYMMdd"
        let currDate = dateFormatter.stringFromDate(date)
        var dateArray = [String]()
        
        var dateToAdd = date
        dateArray.append(currDate)
        for index in 1...29{
            let prevDate = dateToAdd.dateByAddingTimeInterval(-60*60*24*1)
            let prevDateString = dateFormatter.stringFromDate(prevDate)
            
            dateArray.insert(prevDateString, atIndex: 0)
            dateToAdd = prevDate
        }
        return dateArray
    }
    
    
    func callPFObjectQueryGenMonthly(){
        for _ in 1...30{
            self.monthlyData.append(Double(0))
        }
        let genData_Id = (PFUser.currentUser()!["genData_Id"] as? String) ?? ""
        let dateArray = getMonthDate(date)
        let count = dateArray.count
        
        for index in 1...count{
            let query = PFQuery(className: "GenerateData")
            query.whereKey("genData_Id", equalTo: genData_Id)
            query.whereKey("time", containsString: dateArray[index-1])
            
            query.findObjectsInBackgroundWithBlock{
                (objects, error) -> Void in
                if error == nil{
                    if let objects = objects{
                        var sum : Double = 0
                        for object in objects{
                            if let data = object.objectForKey("data") as? Double{
                                sum += data
                                
                            }
                        }
                        self.monthlyData[index-1] = sum
                        
                    }
                }else{
                    NSLog("ERROR : ", (error?.userInfo)!)
                }

        }
        
    }
}
    func getYearMonth(var date: NSDate) -> [String]{
        var yearArray = [String]()
        dateFormatter.dateFormat = "YYMM"
        let calendar = NSCalendar.currentCalendar()
        let currMonth = dateFormatter.stringFromDate(date)
        yearArray.append(currMonth)
        for index in 1...11{
            let preMonth = calendar.dateByAddingUnit(.Month, value: -1, toDate: date, options: NSCalendarOptions.MatchStrictly)
            yearArray.insert(dateFormatter.stringFromDate(preMonth!), atIndex: 0)
            date = preMonth!
        }
        return yearArray
    }
    
    func callPFObjectQueryGenYearly(){
        let yearArray = getYearMonth(date)
        let count = yearArray.count
        for i in 1...12{
            self.yearlyData.append(Double(0))
        }
        let genData_Id = (PFUser.currentUser()!["genData_Id"] as? String) ?? ""
        for index in 1...count{
            var query = PFQuery(className: "GenerateData")
            query.whereKey("genData_Id", equalTo: genData_Id)
            query.whereKey("time", containsString: yearArray[index-1])
            
            query.findObjectsInBackgroundWithBlock{
                (objects, error) -> Void in
                if error == nil{
                    if let objects = objects{
                        var sum : Double = 0
                        for object in objects{
                            if let data = object.objectForKey("data") as? Double{
                                sum += data
                                
                            }
                        }
                        self.yearlyData[index-1] = sum
                        
                    }
                }else{
                    NSLog("ERROR : ", (error?.userInfo)!)
                }
            }
        }
    }
}