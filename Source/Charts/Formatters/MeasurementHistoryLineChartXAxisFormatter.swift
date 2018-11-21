//
//  MeasurementHistoryLineChartFormatter.swift
//  AMP
//
//  Created by trivo on 4/25/18.
//  Copyright © 2018 Tri Vo. All rights reserved.
//

import UIKit

class MeasurementHistoryLineChartXAxisFormatter: NSObject, IAxisValueFormatter {
    private var minValue : Double = 0
    private var midValue : Double = 0
    private var maxValue : Double = 0
    private var minString : String = ""
    private var midString : String = ""
    private var maxString : String = ""
    enum LabelAlignment : Double {
        case left = 0.0
        case mid = 0.5
        case right = 1.0
    }
    
    func setAxisValues(min : Double, max : Double) {
        guard min <= max else { return }
        guard min >= 0, max >= 0 else { return }
        minValue = min
        maxValue = max
        midValue = (max + min)/2
    }
    
    func setAxisLabels(min : String, mid : String, max : String ) {
        minString = min
        midString = mid
        maxString = max
        if min.compareInsensitive(max) == true {
            minString = ""
            maxString = ""
            midString = min
        }
    }
    
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        if value == minValue {
            return minString
        } else if value == midValue {
            return midString
        } else {
            return maxString
        }
    }
    
    func axisLabelInfoForValue(_ value : Double, axis : AxisBase?) -> (String, CGPoint) {
        if value == minValue {
            return (minString, CGPoint.init(x: LabelAlignment.left.rawValue, y: 0.0))
        } else if value == midValue {
            return (midString, CGPoint.init(x: LabelAlignment.mid.rawValue, y: 0.0))
        } else {
            return (maxString, CGPoint.init(x: LabelAlignment.right.rawValue, y: 0.0))
        }
    }
}
