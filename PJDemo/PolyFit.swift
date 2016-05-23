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