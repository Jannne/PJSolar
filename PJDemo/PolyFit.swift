//
//  PolyFit.swift
//  PJDemo
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation
class PolyFit{
    
    //拟合 y = a0 + a1*x
    // 最小二乘法
    // a0 =  (sumX - sumY) * sumXY / (sumX * sumX - n * sumXY)
    // a1 =  (sumX * sumY - n * sumXY) / (sumX * sumX - n * sumXX)
    
    func linearFit(dataNum : Int, xValue: [Double], yValue :[Double]) -> [Double]{
        var data = [Double]()
        var sumX :Double = 0
        var sumY : Double = 0
        var sumXY : Double = 0
        var sumXX : Double = 0
        
        for i in 1...dataNum{
            sumX += xValue[i-1]
            sumY += yValue[i-1]
            sumXX += xValue[i-1] * xValue[i-1]
            sumXY += xValue[i-1] * yValue[i-1]
        }
        let a0 = (sumX - sumY) * sumXY / (sumX * sumX - Double(dataNum) * sumXY)
        let a1 =  (sumX * sumY - Double(dataNum) * sumXY) / (sumX * sumX - Double(dataNum) * sumXX)
        
        data.append(a0)
        data.append(a1)
        return data
        
    }
    
    /*==================polyfit(n,x,y,poly_n,a)===================*/
    /*===============*/
    /*=====n是数据个数 xy是数据值 poly_n是多项式的项数======*/
    /*===，系数比项数多一（常数项）=====*/
    
    //拟合 y = a0 + a1*x + a2 * x^2
    // 最小二乘法
    func parabolicFit(dataNum : Int, xValue: [Double], yValue :[Double]) -> [Double]{
        var data = [Double]()
        var sumX :Double = 0
        var sumY : Double = 0
        var sumXY : Double = 0
        var sumXX : Double = 0
        var sumXXX : Double = 0
        var sumXXXX : Double = 0
        var sumXXY : Double = 0
        for i in 1...dataNum{
            sumX += xValue[i-1]
            sumY += yValue[i-1]
            sumXX +=  pow(xValue[i-1],2.0)
            sumXY += xValue[i-1] * yValue[i-1]
            sumXXX += pow(xValue[i-1], 3.0)
            sumXXXX += pow(xValue[i-1], 4.0)
            sumXXY += pow(xValue[i-1],2.0) * yValue[i-1]
            
        }
        let a01 =  (sumY * sumXX - sumXY * sumX) / (sumXX * sumXX - sumX * sumXXX)
        let a02 =  (sumXXX * sumY - sumX * sumXXY) / (sumXX * sumXXX - sumX * sumXXXX)
        let a03 =  (Double(dataNum) * sumXX - sumX * sumX) / (sumXX * sumXX - sumX * sumXXX)
        let a04 =  (Double(dataNum) * sumXXX - sumX * sumXX) / (sumXX * sumXXX - sumX * sumXXXX)
        
        let a0 = (a01 - a02)/(a03 - a04)
        
        let a11 = (sumXXX * sumY - sumXY * sumXX) / (Double(dataNum) * sumXXX - sumX * sumXX)
        let a12 = (sumXXY * sumXXX - sumXY * sumXXXX ) / (sumXX * sumXXX - sumX * sumXXXX)
        let a13 = (sumX * sumXXX - sumXX * sumXX) / (Double(dataNum) * sumXXX - sumX * sumXX)
        let a14 = (sumXXX * sumXXX - sumXX * sumXXXX) / (sumXX * sumXXX - sumX * sumXXXX)
        let a1 = (a11 - a12) / (a13 - a14)
        
        let a21 = (sumXX * sumY - sumX * sumXY) / (Double(dataNum) * sumXX - sumX * sumX)
        let a22 = (sumXX * sumXXY - sumXY * sumXXX) / (sumXX * sumXX - sumX * sumXXX)
        let a23 = (sumXX * sumXX - sumX * sumXXX) / (Double(dataNum) * sumXX - sumX * sumX)
        let a24 = (sumXXXX * sumXX - sumXXX * sumXXX) / (sumXX * sumXX - sumX * sumXXX)
        let a2 = (a21 - a22) / (a23 - a24)
        
        data.append(a0)
        data.append(a1)
        data.append(a2)
        
        return data
    }
    
    func quadraticFormula(parameter: [Double])->[Double]{
        if(parameter.count != 3){
            return []
        }
        let a = parameter[0]
        let b = parameter[1]
        let c = parameter[2]
        let squared = b * b - 4 * a * c
        if(squared < 0){
            return [-b / (2 * a)]
        }
        else if(squared == 0){
            return [-b / (2 * a)]
        }
        else{
            let x1 = (-b + sqrt(squared)) / (2 * a)
            let x2 = (-b - sqrt(squared)) / (2 * a)
            return [x1,x2]
        }
    }

    
    
    /*==================polyfit(n,x,y,poly_n,a)===================*/
    /*===============*/
    /*=====n是数据个数 xy是数据值 poly_n是多项式的项数======*/
    /*===，系数比项数多一（常数项）=====*/
    
    
    
    //   拟合y=a0+a1*x+a2*x^2+……+apoly_n*x^poly_n
    //   返回a0,a1,a2,……a[poly_n]
    func polyfit(dataNum: Int, xValue : [Double], yValue : [Double], polyN: Int)-> [Double]{
        
        var tempX = [Double](count: dataNum, repeatedValue: 0.0)
        var sumXX = [Double](count: polyN*2+1, repeatedValue: 0.0)
        var tempY = [Double](count: dataNum, repeatedValue: 0.0)
        var sumXY = [Double](count: polyN*2+1, repeatedValue: 0.0)
        var ata = [Double](count: (polyN+1)*(polyN+1), repeatedValue: 0.0)
        
        for i in 0..<dataNum{
            tempX[i] = 1
            tempY[i] = yValue[i]
        }
        for i in 0..<(2*polyN+1){
            for j in 0..<polyN{
                sumXX[i] += tempX[j]
                tempX[j] *= xValue[j]
            }
        }
        
        for i in 0..<(polyN+1){
            for j in 0..<polyN{
                sumXY[i] += tempY[j]
                tempY[j] *= xValue[j]
            }
        }
        
        for i in 0..<(polyN+1){
            for j in 0..<(polyN+1){
                ata[i*(polyN+1)+j] = sumXX[i+j-2]
            }
        }
         return gauss_solve(polyN+1, _aValue: ata, _bValue: sumXY)
    }
    
    func gauss_solve(polyN: Int, _aValue : [Double], _bValue: [Double])->[Double]{
        var aValue = _aValue
        var bValue = _bValue
        for k in 0..<polyN{
            var max = fabs(aValue[k*polyN + k])
            var r = k
            for i in k+1..<polyN-1{ // find Max
                if(max < fabs(aValue[i*polyN + i])){
                    max = fabs(aValue[i*polyN + i])
                    r = i
                }
            }
            
            if(r != k){  //change array: aValue[k]& aValue[r]
                for i in 0..<polyN{
                    max = aValue[k*polyN + i]
                    aValue[k*polyN + i] = aValue[r*polyN + i]
                    aValue[r*polyN + i] = max
                }
            }
            
            max = bValue[k]
            bValue[k] = bValue[r]
            bValue[r] = max
            
            for i in (k+1)..<polyN{
                for j in (k+1)..<polyN{
                    aValue[i*polyN+j]-=aValue[i*polyN+k]*aValue[k*polyN+j]/aValue[k*polyN+k];
                    bValue[i]-=aValue[i*polyN+k]*bValue[k]/aValue[k*polyN+k];
                }
            }
            
        }
        var xArray = [Double](count: polyN, repeatedValue: 0.0)
        for i in (polyN-1)...0{
            xArray[i] /= aValue[i*polyN + i]
            for j in (i+1)..<polyN{
                xArray[i] = bValue[i]
                xArray[i] -= (aValue[i*polyN + j] * xArray[j])
            }
        }
        return xArray
    }
    

}