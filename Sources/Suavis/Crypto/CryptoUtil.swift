//
//  CryptoUtil.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation

// 加密工具 - 静态方法
public enum CryptoUtil {
    /// 计算字符串的 MD5 哈希值
    /// - Parameters:
    ///   - string: 要计算哈希值的字符串
    /// - Returns: 字符串的 MD5 哈希值
    public static func md5(_ string: String) -> String {
        // MD5实现
        return ""
    }
    
    /// 计算字符串的 SHA256 哈希值
    /// - Parameters:
    ///   - string: 要计算哈希值的字符串
    /// - Returns: 字符串的 SHA256 哈希值
    public static func sha256(_ string: String) -> String {
        // SHA256实现
        return ""
    }
}

public typealias _CryptoUtil = CryptoUtil

extension Suavis {
    public typealias CryptoUtil = _CryptoUtil
}
