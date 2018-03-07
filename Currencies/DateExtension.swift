//
//  DateExtension.swift
//  Fruits
//
//  Created by Jakub Hutny on 23.10.2016.
//  Copyright © 2016 Jakub Hutny. All rights reserved.
//

import Foundation

extension Date {
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    func twoDays(before date: Date) -> Date {
        var periodComponents = DateComponents()
        periodComponents.day = -2
        
        return NSCalendar.current.date(byAdding: periodComponents, to: date)!
    }
    
    func day(before date: Date) -> Date {
        var periodComponents = DateComponents()
        periodComponents.day = -1
        
        return NSCalendar.current.date(byAdding: periodComponents, to: date)!
    }
    
    func halfADay(before date: Date) -> Date {
        var periodComponents = DateComponents()
        periodComponents.hour = -12
        
        return NSCalendar.current.date(byAdding: periodComponents, to: date)!
    }
    
    func getYear() -> Int {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        
        return (calendar?.component(NSCalendar.Unit.year, from: self))!
    }
    
    func getMonth() -> Int {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        
        return (calendar?.component(NSCalendar.Unit.month, from: self))!
    }
    
    func getDay() -> Int {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        
        return (calendar?.component(NSCalendar.Unit.day, from: self))!
    }
    
    func getHour() -> Int {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        
        return (calendar?.component(NSCalendar.Unit.hour, from: self))!
    }
    
    func getMinute() -> Int {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        
        return (calendar?.component(NSCalendar.Unit.minute, from: self))!
    }
    
    func addDays(plus: Int) -> Date {
        let interval = TimeInterval(plus * 60 * 60 * 24)
        
        return self.addingTimeInterval(interval)
    }
    
    func addHours(plus: Int) -> Date {
        let interval = TimeInterval(plus * 60 * 60)
        
        return self.addingTimeInterval(interval)
    }
    
    func addMinutes(plus: Int) -> Date {
        let interval = TimeInterval(plus * 60)
        
        return self.addingTimeInterval(interval)
    }
}
