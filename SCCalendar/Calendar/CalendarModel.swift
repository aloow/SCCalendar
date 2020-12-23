//
//  CalendarModel.swift
//  SCCalendar
//
//  Created by WaQing on 2020/12/22.
//

import Foundation
import SwiftDate

struct YearInfo: Codable {
    
    struct DayInfo :Codable {
        let day:Int
        let title:String
        let subTitle:String
        let author:String
    }
    
    let january :[DayInfo]
    let february :[DayInfo]
    
//    let March :[DayInfo]
//    let April :[DayInfo]
//
//    let May :[DayInfo]
//    let June :[DayInfo]
//
//    let July :[DayInfo]
//    let August :[DayInfo]
//
//    let September :[DayInfo]
//    let October :[DayInfo]
//
//    let November :[DayInfo]
    let december :[DayInfo]
    
    
    func getDayInfoWith(date:Date) -> DayInfo? {
        let month = date.month
        print("month: \(month)")
        switch month {
        case 1:
            return january[date.day]
        case 2:
            return february[date.day]
        default:return nil
        }
    }
    
    
}
