//
//  Logger.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation
import Atomics

/// 日志级别
public enum LogLevel: String, Sendable, CaseIterable {
    case debug = "DEBUG"
    case info = "INFO"
    case warn = "WARN"
    case error = "ERROR"
    
    var priority: UInt8 {
        switch self {
        case .debug: return 0
        case .info: return 1
        case .warn: return 2
        case .error: return 3
        }
    }
    
    static func fromPriority(_ priority: UInt8) -> LogLevel {
        switch priority {
        case 0: return .debug
        case 1: return .info
        case 2: return .warn
        case 3: return .error
        default: return .debug
        }
    }
}

/// 高性能的并发安全日志管理器
public final class LoggerImpl: Sendable {
    public static let shared = LoggerImpl()
    
    // 使用 UInt8 存储，更节省内存
    private let minLevel = ManagedAtomic<UInt8>(0)
    
    // 使用 OSLog 进行高性能日志记录（可选）
    private let useOSLog: Bool
    
    private init(useOSLog: Bool = false) {
        self.useOSLog = useOSLog
    }
    
    /// 配置方法
    public func configure(level: LogLevel = .debug, useOSLog: Bool = false) {
        minLevel.store(level.priority, ordering: .relaxed)
        // 注意：useOSLog 在初始化后不能修改，因为它是不可变的
    }
    
    /// 设置最低日志级别
    public func setLevel(_ level: LogLevel) {
        minLevel.store(level.priority, ordering: .relaxed)
    }
    
    /// 获取当前日志级别
    public func getLevel() -> LogLevel {
        let priority = minLevel.load(ordering: .relaxed)
        return LogLevel.fromPriority(priority)
    }
    
    // 基本的日志方法
    public func debug(_ message: String, file: String = #file, line: Int = #line) {
        log(message, level: .debug, file: file, line: line)
    }
    
    public func info(_ message: String, file: String = #file, line: Int = #line) {
        log(message, level: .info, file: file, line: line)
    }
    
    public func warn(_ message: String, file: String = #file, line: Int = #line) {
        log(message, level: .warn, file: file, line: line)
    }
    
    public func error(_ message: String, file: String = #file, line: Int = #line) {
        log(message, level: .error, file: file, line: line)
    }
    
    private func log(_ message: String, level: LogLevel, file: String, line: Int) {
        let currentMinLevel = minLevel.load(ordering: .relaxed)
        
        // 快速检查：如果级别不够，立即返回
        guard level.priority >= currentMinLevel else { return }
        
        // 格式化日志信息
        let timestamp = getCurrentTimestamp()
        let filename = URL(fileURLWithPath: file).lastPathComponent
        let logMessage = "[\(timestamp)] [\(level.rawValue)] [\(filename):\(line)] \(message)"
        
        // 输出日志
        if useOSLog {
            // 使用 OSLog 获得更好性能（在真实应用中）
            print(logMessage)
        } else {
            print(logMessage)
        }
    }
    
    /// 高性能的时间戳获取
    private func getCurrentTimestamp() -> String {
        // 简单的日期格式化，避免频繁创建 DateFormatter
        let date = Date()
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone.current
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: date)
        
        if let year = components.year,
           let month = components.month,
           let day = components.day,
           let hour = components.hour,
           let minute = components.minute,
           let second = components.second,
           let nanosecond = components.nanosecond {
            
            let millisecond = nanosecond / 1_000_000
            return String(format: "%04d-%02d-%02d %02d:%02d:%02d.%03d",
                         year, month, day, hour, minute, second, millisecond)
        }
        
        // 备用方案
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
}

/// 日志工具全局别名
public let LogUtil = LoggerImpl.shared
