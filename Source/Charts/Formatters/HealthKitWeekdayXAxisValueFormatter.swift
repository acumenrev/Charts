//
//  HealthKitWeekdayValueFormatter.swift
//  AMP
//
//  Created by trivo on 7/12/18.
//  Copyright © 2018 Tri Vo. All rights reserved.
//

import Foundation


class HealthKitWeekdayXAxisValueFormatter : NSObject, IAxisValueFormatter {
    enum DisplayType {
        case baseOnData, specificDates
    }
    fileprivate var displayType = DisplayType.baseOnData
    var data : [HKBaseModel] = [HKBaseModel]()
    var timeFilterType : HealthKitGraphWorker.GraphTimeFilterType? = nil
    fileprivate lazy var df = DateFormatter()
    fileprivate lazy var chartStartDate : Date = Date()
    fileprivate lazy var chartEndDate : Date = Date()
    init(withData data : [HKBaseModel]) {
        super.init()
        self.data = data
        self.displayType = .baseOnData
    }

    private func initDateFormatter() {
        df.dateFormat = AppConstants.DateTime.HealthKitGraphYearYAxis
    }

    init(data: [HKBaseModel], startDate : Date, endDate : Date) {
        super.init()
        self.displayType = .specificDates
        self.chartStartDate = startDate
        self.chartEndDate = endDate
        self.data = data
    }

    init(data : [HKBaseModel], timeFilterType : HealthKitGraphWorker.GraphTimeFilterType) {
        super.init()
        self.initDateFormatter()
        self.data = data
        self.timeFilterType = timeFilterType
        self.displayType = .baseOnData
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let intValue = Int.init(value)
        
        var stringVal : String = ""
        if self.displayType == .baseOnData {
            if intValue < data.count {
                if let timeFilter = timeFilterType {
                    switch timeFilter {
                    case .year:
                        initDateFormatter()
                        stringVal = df.string(from: data[intValue].date)
                    case .month:
                        if value == 0 {
                            stringVal = "1"
                        } else {
                            if value == Double(data.count - 1) {
                                stringVal = Int(value + 1).string
                            } else if value == Double(((data.count/2) - 1)) {
                                stringVal = Int(value + 1).string
                            }
                        }
                    case .week:
                        stringVal = getWeekdayString(value: data[intValue])
                    }
                } else {
                    stringVal = getWeekdayString(value: data[intValue])
                }
            }
        } else {
            let date = self.chartStartDate.adding(.day, value: intValue)
            stringVal = getWeekdayStringWithWeekday(value: date.weekday)
        }

        return stringVal
    }

    private func getWeekdayStringWithWeekday(value : Int) -> String {
        var result = ""
        switch value {
        case 1:
            result = "Su"
            break
        case 2:
            result = "Mo"
            break
        case 3:
            result = "Tu"
            break
        case 4:
            result = "We"
            break
        case 5:
            result = "Th"
            break
        case 6:
            result = "Fr"
            break
        case 7:
            result = "Sa"
            break
        default:
            result = ""
        }

        return result
    }
    
    private func getWeekdayString(value : HKBaseModel) -> String {
        let result = self.getWeekdayStringWithWeekday(value: value.date.weekday)
        return result
    }
}
