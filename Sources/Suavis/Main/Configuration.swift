// Sources/Suavis/Main/Configuration.swift

/// 配置结构体
public struct Configuration: Sendable {
    /// API 密钥
    public let apiKey: String
    
    /// 运行环境
    public let environment: Environment
    
    /// 默认配置
    public static let `default` = Configuration(
        apiKey: "",
        environment: .development
    )
    
    /// 创建配置
    /// - Parameters:
    ///   - apiKey: API 密钥
    ///   - environment: 运行环境
    public init(apiKey: String, environment: Environment) {
        self.apiKey = apiKey
        self.environment = environment
    }
}

/// 环境枚举
public enum Environment: Sendable {
    /// 开发环境
    case development
    /// 生产环境
    case production
}