//
//  IdGenerator.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation
import Atomics

/// ID生成器实现类
public final class IdGeneratorImpl: Sendable {
    public static let shared = IdGeneratorImpl()
    
    private let workerId: ManagedAtomic<Int>
    private let sequence: ManagedAtomic<Int>
    
    private init() {
        self.workerId = ManagedAtomic(0)
        self.sequence = ManagedAtomic(0)
    }
    
    /// 配置工作节点ID
    public func configure(workerId: Int) {
        self.workerId.store(workerId, ordering: .relaxed)
    }
    
    /// 生成唯一ID（雪花算法）
    public func nextId() -> Int64 {
        let currentSequence = sequence.wrappingIncrementThenLoad(ordering: .relaxed)
        let timestamp = Int64(Date().timeIntervalSince1970 * 1000)
        let currentWorkerId = workerId.load(ordering: .relaxed)
        
        return (timestamp << 22) | (Int64(currentWorkerId) << 12) | Int64(currentSequence & 0xFFF)
    }
}

/// ID工具全局别名，可直接使用 IdUtil.nextId()
public let IdUtil = IdGeneratorImpl.shared
