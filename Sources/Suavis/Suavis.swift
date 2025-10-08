// The Swift Programming Language
// https://docs.swift.org/swift-book

// Sources/MySwiftLibrary/MySwiftLibrary.swift

/// 主库类
public final class Suavis: Sendable {
    
    let configuration: Configuration
    
    public init(configuration: Configuration = .default) {
        self.configuration = configuration
    }
    
    /// 示例公共方法
    public func greet(name: String) -> String {
        return "Hello, \(name)!"
    }
    
    /// 异步方法示例
    public func fetchData() async throws -> String {
        // 模拟异步操作
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return "Data fetched successfully"
    }
}

// 配置结构体
public struct Configuration: Sendable {
    public let apiKey: String
    public let environment: Environment
    
    public static let `default` = Configuration(
        apiKey: "",
        environment: .development
    )
    
    public init(apiKey: String, environment: Environment) {
        self.apiKey = apiKey
        self.environment = environment
    }
}

public enum Environment: Sendable {
    case development
    case production
}
