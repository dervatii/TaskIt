//
//  Date.swift
//  TaskIt
//
//  Created by Diego Valderrama on 2/17/15.
//  Copyright (c) 2015 Diego Valderrama. All rights reserved.
//

import Foundation

class Date {
    
    class func from (#year:Int, month: Int, day: Int) -> NSDate{
        
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)
        var date = gregorianCalendar?.dateFromComponents(components)
        
        return date!
    }
    
    //Converts a date into a string
    class func toString (#date:NSDate) -> String {
        
        let dateStringFormater = NSDateFormatter()
        dateStringFormater.dateFormat = "yyyy-MM-dd"//"mm" is for minutes, like HH:mm. In this case, we need the months, along with the days and year, so that formatting is the one we use.  The format "HH:mm a" This will show the time in 12 hour format with am/pm at the end.
        let dateString = dateStringFormater.stringFromDate(date)
        
        return dateString
    }
    
    
    
}
