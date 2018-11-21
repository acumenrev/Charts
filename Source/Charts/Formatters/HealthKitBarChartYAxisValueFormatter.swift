//
//  HealthKitBarChartYAxisValueFormatter.swift
//  AMP
//
//  Created by trivo on 7/17/18.
//  Copyright © 2018 Tri Vo. All rights reserved.
//

import Foundation

class HealthKitBarChartYAxisValueFormatter : NSObject, IAxisValueFormatter {
    private(set) var minValue : (Double, String) = (0.0, "0")
    private(set) var midValue : (Double, String) = (15.0, "15k")
    private(set) var maxValue : (Double, String) = (30.0, "30k")
    
    func setMin(_ value : (Double, String)) {
        self.minValue = value
    }
    
    func setMid(_ value : (Double, String)) {
        self.midValue = value
    }
    
    func setMax(_ value : (Double, String)) {
        self.maxValue = value
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value == minValue.0 {
            return minValue.1
        } else if value == midValue.0 {
            return midValue.1
        } else {
            return maxValue.1
        }
    }
}
