//
//  Date+Extensions.swift
//  DEV
//
//  Created by Hadi on 02/05/2021.
//

import Foundation

extension Date {
    ///
    /// Provides a humanised date. For instance: 1 minute, 1 hour ago
    ///
    /// - Parameters:
    //      - numericDates: Set it to true to get "1 hour ago", "1 minute ago" or false if you prefer "An hour ago", "A minute ago"
    ///
    func timeAgo(numericDates: Bool = true) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = self < now ? self : now
        let latest = self > now ? self : now

        let unitFlags: Set<Calendar.Component> = [.minute, .hour]
        let components: DateComponents = calendar.dateComponents(unitFlags, from: earliest, to: latest)

        if let hour = components.hour {
            if hour >= 24 {
                return ""
            }
            if hour >= 2 {
                return "\(hour) hours ago"
            } else if hour >= 1 {
                return numericDates ? "1 hour ago" : "An hour ago"
            }
        }
        if let minute = components.minute {
            if minute >= 2 {
                return "\(minute) minutes ago"
            } else if minute >= 1 {
                return numericDates ? "1 minute ago" : "A minute ago"
            }
        }
        if let second = components.second {
            if second >= 3 {
                return "\(second) seconds ago"
            }
        }
        return "Just now"
    }
}
