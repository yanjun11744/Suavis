//
//  IdGenerator.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation

/// ID生成器实现类
public final class IdGeneratorImpl {
    public static let shared = IdGeneratorImpl()
    
    private var workerId: Int = 0
    private var sequence: Int = 0
    private let lock = NSLock()
    
    private init() {}
    
    /// 配置工作节点ID
    public func configure(workerId: Int) {
        lock.lock()
        defer { lock.unlock() }
        self.workerId = workerId
    }
    
    /// 生成唯一ID（雪花算法）
    public func nextId() -> Int64 {
        lock.lock()
        defer { lock.unlock() }
        
        sequence += 1
        let timestamp = Int64(Date().timeIntervalSince1970 * 1000)
        return (timestamp << 22) | (Int64(workerId) << 12) | Int64(sequence & 0xFFF)
    }
}

/// ID工具全局别名，可直接使用 IdUtil.nextId()
public let IdUtil = IdGeneratorImpl.shared
