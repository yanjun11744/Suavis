//
//  Logger.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation

/// 日志级别
public enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warn = "WARN"
    case error = "ERROR"
}

/// 日志管理器实现类
public final class LoggerImpl {
    public static let shared = LoggerImpl()
    
    private var minLevel: LogLevel = .debug
    private var dateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    }
    
    /// 设置最低日志级别
    public func setLevel(_ level: LogLevel) {
        self.minLevel = level
    }
    
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
        let timestamp = dateFormatter.string(from: Date())
        let filename = (file as NSString).lastPathComponent
        print("[\(timestamp)] [\(level.rawValue)] [\(filename):\(line)] \(message)")
    }
}

/// 日志工具全局别名，可直接使用 LogUtil.info()
public let LogUtil = LoggerImpl.shared
