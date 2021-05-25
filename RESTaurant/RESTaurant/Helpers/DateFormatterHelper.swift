//
//  DateFormatterHelper.swift
//  RESTaurant
//
//  Created by Евгений Кузьмин on 24.05.2021.
//

import Foundation

class DateFormatterHelper {

    class func getHoursAndMinutedFromDate(date: String) -> String {
        let fromDateFormatter = ISO8601DateFormatter()
        if let fromIndex = date.firstIndex(of: "."), let toIndex = date.firstIndex(of: "+") {
            var normalizedStringDate = date
            normalizedStringDate.removeSubrange(fromIndex..<toIndex)
            if let date = fromDateFormatter.date(from: normalizedStringDate) {
                let toDateFormatter = DateFormatter()
                toDateFormatter.timeZone = TimeZone(abbreviation: "GMT+3")
                toDateFormatter.dateFormat = "HH:mm"
                let dateString = toDateFormatter.string(from: date)
                return dateString
            }
        }
        return ""
    }
}
