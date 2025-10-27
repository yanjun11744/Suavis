//
//  ArrayUtil.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation

public enum ArrayUtil {
    /// 判断数组是否为空
    /// - Parameters:
    ///   - array: 要判断的数组
    /// - Returns: 如果数组为空或 nil，则返回 true；否则返回 false
    public static func isEmpty<T>(_ array: [T]?) -> Bool {
        return array?.isEmpty ?? true
    }
    
    /// 将数组分块
    /// - Parameters:
    ///   - array: 要分块的数组
    ///   - size: 每个块的大小
    /// - Returns: 分块后的数组
    public static func chunk<T>(_ array: [T], size: Int) -> [[T]] {
        return stride(from: 0, to: array.count, by: size).map {
            Array(array[$0..<min($0 + size, array.count)])
        }
    }
}

public typealias _ArrayUtil = ArrayUtil

extension Suavis {
    public typealias ArrayUtil = _ArrayUtil
}
