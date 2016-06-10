//
//  DrawCharts.swift
//  PJDemo
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
import Charts


var chartColors : [UIColor] = [UIColor.lightGrayColor().colorWithAlphaComponent(0.5),UIColor(red: 127/255, green: 1, blue: 212/255, alpha: 0.8), UIColor(red: 1, green: 250/255, blue: 205/255, alpha: 0.8), UIColor.purpleColor(), UIColor.yellowColor(),UIColor(red: 123/255, green: 104/255, blue: 238/255, alpha: 0.6)]
//(127,255,212) (255,250,205)(123,104,238)

var lineColors : [UIColor] = [UIColor(red: 178/255, green: 34/255, blue: 34/255, alpha: 1), UIColor(red: 60/255, green: 179/255, blue: 113/255, alpha: 1)]

var pieColors : [UIColor] = [UIColor.lightGrayColor(), UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.7)]
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
func randomColor()->UIColor
{
    let red = Double(arc4random_uniform(256))
    let green = Double(arc4random_uniform(256))
    let blue = Double(arc4random_uniform(256))
    let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
    return color
}

func drawRadarChart(radarChartView:RadarChartView, dataPoints : [String], values: [Double])
{
    var dataEntries : [ChartDataEntry] = []
    for i in 0..<dataPoints.count{
        let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
        dataEntries.append(dataEntry)
    }
    let radarChartDataSet = RadarChartDataSet(yVals: dataEntries, label: "")
    radarChartDataSet.lineWidth = 2.0
    radarChartDataSet.colors = chartColors
    
    let radarChartData = RadarChartData(xVals: dataPoints, dataSet: radarChartDataSet)
    radarChartView.data = radarChartData
    radarChartView.descriptionText = "Comparison"
    radarChartView.animate(xAxisDuration: 2)
    
    
}

func drawMultiRadarChart(radarChartView: RadarChartView, dataPoints: [String], values: [[Double]], labels:[String] = [])
{
    var dataSets = [RadarChartDataSet]()
    for i in 0..<values.count
    {
        var dataEntries = [ChartDataEntry]()
        for j in 0..<values[i].count{
            let dataEntry = ChartDataEntry(value: (values[i])[j], xIndex: j)
            dataEntries.append(dataEntry)
        }
        let radarChartDataSet = RadarChartDataSet(yVals: dataEntries, label: labels[i])
        radarChartDataSet.lineWidth = 5
        radarChartDataSet.colors = [chartColors[i+1]]
        
        dataSets.append(radarChartDataSet)
    
    }
    radarChartView.descriptionText = "Radar Chart"
    let data : RadarChartData = RadarChartData(xVals: dataPoints, dataSets: dataSets)

    radarChartView.data = data
}


func drawMultiLineCharts(lineChartView:LineChartView,dataPoints:[String],values:[[Double]],labels:[String] = [])
{
    var dataSets : [LineChartDataSet] = [LineChartDataSet]()
    for i in 0..<values.count
    {
        var dataEntries : [ChartDataEntry] = []
        for j in 0..<values[i].count
        {
            let dataEntry = ChartDataEntry(value: (values[i])[j], xIndex: j)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: labels[i])
        lineChartDataSet.circleRadius = 0.2
        lineChartDataSet.circleColors = [UIColor.blackColor()]
        lineChartDataSet.lineWidth = 5
        lineChartDataSet.circleColors = [chartColors[i]]
        setChartLineData(lineChartDataSet, color:lineColors[i] )
        dataSets.append(lineChartDataSet)
        
    }
    let data: LineChartData = LineChartData(xVals: dataPoints, dataSets: dataSets)
    lineChartView.descriptionText = ""
    lineChartView.data = data
    
    
}

func drawCubicCharts(lineChartView : LineChartView,dataPoints: [String], values: [Double]){
    var dataEntries : [ChartDataEntry] = []
    for i in 0 ..< dataPoints.count{
        let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
        dataEntries.append(dataEntry)
    }
    let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Generation")
    lineChartDataSet.lineWidth = 1
    lineChartDataSet.circleRadius = 0.2
    lineChartDataSet.drawCubicEnabled = true
    lineChartDataSet.drawFilledEnabled = true
    lineChartDataSet.fillColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.5)
    
    lineChartDataSet.colors = [UIColor.lightGrayColor().colorWithAlphaComponent(0.4)]
    //setChartLineData(lineChartDataSet, color: UIColor.darkGrayColor().colorWithAlphaComponent(0.5))
    let lineChartData = LineChartData(xVals: dataEntries, dataSet: lineChartDataSet)
    lineChartView.data = lineChartData
    lineChartView.descriptionText = ""
    lineChartView.backgroundColor = UIColor.whiteColor()
    lineChartView.gridBackgroundColor = UIColor.whiteColor()
    lineChartView.xAxis.labelPosition = .BottomInside
    lineChartView.leftAxis.labelPosition = .OutsideChart
    
    lineChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
}

func drawLineCharts(lineChartView:LineChartView,dataPoints : [String],values: [Double])
{
    
    var dataEntries : [ChartDataEntry] = []
    for i in 0 ..< dataPoints.count{
        let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
        dataEntries.append(dataEntry)
    }
    let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "")
    lineChartDataSet.lineWidth = 5
    lineChartDataSet.circleRadius = 0.2
    
    setChartLineData(lineChartDataSet, color: UIColor.lightGrayColor().colorWithAlphaComponent(0.5))
    let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
    lineChartView.data = lineChartData
    lineChartView.descriptionText = ""
    lineChartView.animate(xAxisDuration: 1.0, easingOption: ChartEasingOption.Linear)
    
}


func drawPieCharts(pieChartView:PieChartView,dataPoints : [String],values: [Double], description: String)
{
    var dataEntries : [ChartDataEntry] = []
    for i in 0 ..< dataPoints.count{
        let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
        dataEntries.append(dataEntry)
    }
    
    let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
    let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
    pieChartView.data = pieChartData
    pieChartView.descriptionText = description
    pieChartView.legend.position = ChartLegend.ChartLegendPosition.BelowChartCenter
    var colors : [UIColor] = []
    
    for i in 0..<dataPoints.count {
        colors.append(pieColors[i])
    }
    pieChartDataSet.colors = colors
    pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    
}
func drawMultiBarCharts(barChartView:BarChartView,dataPoints : [String],values: [[Double]],labels:[String])
{
    var dataSets : [BarChartDataSet] = [BarChartDataSet]()
    for i in 0..<values.count
    {
        var dataEntries : [BarChartDataEntry] = []
        for j in 0..<values[i].count
        {
            let dataEntry = BarChartDataEntry(value: (values[i])[j], xIndex: j)
            dataEntries.append(dataEntry)
        }
        let barChartDataSet = BarChartDataSet(yVals: dataEntries, label: labels[i])
        //barChartDataSet.colors = [randomColor()]
        barChartDataSet.colors = [chartColors[i]]
        dataSets.append(barChartDataSet)
        
    }
    let data: BarChartData = BarChartData(xVals: dataPoints, dataSets: dataSets)
    barChartView.data = data
    barChartView.descriptionText = ""
    barChartView.xAxis.labelPosition = .Bottom
    //barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption:)
    barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    
}

func drawBarCharts(barChartView:BarChartView,dataPoints : [String],values: [Double],labelText: String)
{
    barChartView.fitScreen()
    var dataEntries : [BarChartDataEntry] = []
    for i in 0 ..< dataPoints.count{
        let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
        dataEntries.append(dataEntry)
    }
    
    let barChartDataSet = BarChartDataSet(yVals: dataEntries, label: labelText)
    

    let barChartData = BarChartData(xVals: dataPoints, dataSet: barChartDataSet)
    
    barChartDataSet.colors = ChartColorTemplates.vordiplom()
    barChartDataSet.barSpace = 0.5

    barChartData.setValueTextColor(UIColor.darkGrayColor())
    //barChartView.setVisibleXRange(minXRange: 10, maxXRange: 10)
   // barChartView.setVisibleXRangeMaximum(10)
    //barChartView.zoom((CGFloat)(dataPoints.count/24), scaleY: 1, x: barChartView.center.x, y: barChartView.center.y)
    barChartView.scaleXEnabled = true
    barChartView.scaleYEnabled = true
    barChartView.data = barChartData
    barChartView.descriptionText = " "
    barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    
}



func drawHorizontalBarCharts(barChartView:HorizontalBarChartView,dataPoints : [String],values: [Double])
{
    var dataEntries : [BarChartDataEntry] = []
    for i in 0 ..< dataPoints.count{
        let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
        dataEntries.append(dataEntry)
    }
    
    let barChartDataSet = BarChartDataSet(yVals: dataEntries, label: "Photovoltaic Generation Comparison")
    let barChartData = BarChartData(xVals: dataPoints, dataSet: barChartDataSet)
    barChartDataSet.colors = [UIColor.redColor().colorWithAlphaComponent(0.5),UIColor.lightGrayColor().colorWithAlphaComponent(0.5)]
    barChartView.data = barChartData
    barChartView.descriptionText = ""
    //barChartView.descriptionText = "Photovoltaic Generation Comparison"
    //barChartView.descriptionTextPosition = CGPoint(x: barChartView.center.x + barChartView.bounds.width/2, y: barChartView.center.y + barChartView.bounds.height)
    barChartView.animate(yAxisDuration: 2.0)
    
}
