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
        let day:String
        let title:String
        let subTitle:String
        let author:String
    }
    let january :[String:DayInfo]
//    let january :[DayInfo]
//    let february :[DayInfo]
    
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
//    let december :[DayInfo]
    
    // 根据日期获取对应数据
    func getDayInfoWith(date:Date) -> DayInfo? {
        let month = date.month
        var dayString = ""
        if date.day < 10 {
            dayString = String(format: "%02x", date.day)
        } else {
            dayString = "\(date.day)"
        }
        switch month {
        case 1:
            return january[dayString]
//        case :
//            return february[date.day]
        default:return nil
        }
    }
    
    // 从本地json加载数据
    // MARK: 读取JSON
    func readJsonFile(fileName name:String = "2021") -> YearInfo? {
        
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            return nil
        }
        
        let localData = NSData.init(contentsOfFile: path)! as Data
        
        do {
            // banner即为我们要转化的目标model
            let result = try JSONDecoder().decode(YearInfo.self, from: localData)
            return result
        } catch {
            debugPrint("banner===ERROR")
            return nil
        }
        
    }
    
    
}
