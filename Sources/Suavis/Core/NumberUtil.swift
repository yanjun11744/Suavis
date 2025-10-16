//
//  NumberUtil.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//
import Foundation

public enum NumberUtil {
    public static func round(_ value: Double, scale: Int) -> Double {
        let multiplier = pow(10.0, Double(scale))
        return (value * multiplier).rounded() / multiplier
    }
}

public typealias _NumberUtil = NumberUtil

extension Suavis {
    public typealias NumberUtil = _NumberUtil
}
