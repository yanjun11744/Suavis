//
//  DateUtil.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation

// 日期工具（静态方法）
public enum DateUtil {
    /// 格式化日期为字符串
    /// - Parameters:
    ///   - date: 要格式化的日期
    ///   - pattern: 日期格式模式，默认值为 "yyyy-MM-dd HH:mm:ss"
    /// - Returns: 格式化后的日期字符串
    public static func format(_ date: Date, pattern: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = pattern
        return formatter.string(from: date)
    }
    
    /// 解析字符串为日期
    /// - Parameters:
    ///   - dateStr: 要解析的日期字符串
    ///   - pattern: 日期格式模式，默认值为 "yyyy-MM-dd"
    /// - Returns: 解析后的日期对象，如果解析失败则返回 nil
    public static func parse(_ dateStr: String, pattern: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = pattern
        return formatter.date(from: dateStr)
    }
}

public typealias _DateUtil = DateUtil

extension Suavis {
    public typealias DateUtil = _DateUtil
}
