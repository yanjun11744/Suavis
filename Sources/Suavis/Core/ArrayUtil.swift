//
//  ArrayUtil.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation

public enum ArrayUtil {
    public static func isEmpty<T>(_ array: [T]?) -> Bool {
        return array?.isEmpty ?? true
    }
    
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
