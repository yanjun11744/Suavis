//
//  StrUtil.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation

/// 字符串工具类
public enum StrUtil {
    /// 判断字符串是否为空或 nil
    ///
    /// ## 函数签名
    /// `isEmpty(_ str: String?) -> Bool`
    ///
    /// - Parameter str: 要检查的字符串，可选类型
    /// - Returns: 如果字符串为 nil 或空字符串返回 true，否则返回 false
    ///
    /// ## 示例
    /// ```swift
    /// StrUtil.isEmpty(nil)       // true
    /// StrUtil.isEmpty("")        // true
    /// StrUtil.isEmpty("hello")   // false
    /// ```
    public static func isEmpty(_ str: String?) -> Bool {
        return str?.isEmpty ?? true
    }
    
    /// 去除首尾空格
    public static func trim(_ str: String) -> String {
        return str.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 转换为驼峰命名
    public static func camelCase(_ str: String) -> String {
        let components = str.components(separatedBy: "_")
        return components.enumerated().map { index, component in
            index == 0 ? component.lowercased() : component.capitalized
        }.joined()
    }
}

public typealias _StrUtil = StrUtil

extension Suavis {
    public typealias StrUtil = _StrUtil
}
