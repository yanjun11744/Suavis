//
//  CryptoUtil.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation

// 加密工具 - 静态方法
public enum CryptoUtil {
    public static func md5(_ string: String) -> String {
        // MD5实现
        return ""
    }
    
    public static func sha256(_ string: String) -> String {
        // SHA256实现
        return ""
    }
}

public typealias _CryptoUtil = CryptoUtil

extension Suavis {
    public typealias CryptoUtil = _CryptoUtil
}
