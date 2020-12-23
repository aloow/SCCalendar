//
//  ContentViewController.swift
//  SCCalendar
//
//  Created by iMac on 2020/12/16.
//

import UIKit
import FSCalendar
import SwiftDate

class ContentViewController: UIViewController {
    
    let startDate = ("2021-1-01".toDate()?.date) ?? Date()
    var endDate: Date {
        return startDate + 1.years
    }
    
    @IBOutlet weak var calendarView: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setCalendar()
        
        
    }
    
    func setCalendar() {
        
        calendarView.appearance.headerDateFormat = "MM月"
//        calendarView.appearance.headerTitleColor = UIColor(hex: 0xFCE4CB)
        calendarView.today = Date()
    }

}

extension ContentViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if let targetVC = self.parent?.parent as? ViewController {
            targetVC.didSelect(date: date)
        }
    }
    
}


extension ContentViewController: FSCalendarDataSource {
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        startDate
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        endDate
    }
    
    
}
