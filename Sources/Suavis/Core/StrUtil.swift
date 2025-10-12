//
//  StrUtil.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation

/// 字符串工具类
public enum StrUtil {
    /// 判断字符串是否为空
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
