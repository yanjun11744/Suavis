//
//  NumberUtil.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//
import Foundation

public enum NumberUtil {
    /// 对 Double 类型的数值进行四舍五入
    /// - Parameters:
    ///   - value: 要四舍五入的数值
    ///   - scale: 保留的小数位数
    /// - Returns: 四舍五入后的数值
    public static func round(_ value: Double, scale: Int) -> Double {
        let multiplier = pow(10.0, Double(scale))
        return (value * multiplier).rounded() / multiplier
    }
}

public typealias _NumberUtil = NumberUtil

extension Suavis {
    public typealias NumberUtil = _NumberUtil
}
