//
//  DateUtil.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation

// 日期工具（静态方法）
public enum DateUtil {
    public static func format(_ date: Date, pattern: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = pattern
        return formatter.string(from: date)
    }
    
    public static func parse(_ dateStr: String, pattern: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = pattern
        return formatter.date(from: dateStr)
    }
}
