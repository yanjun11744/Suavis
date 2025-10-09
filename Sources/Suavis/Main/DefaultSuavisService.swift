// Sources/Suavis/Main/DefaultSuavisService.swift

/// Suavis 服务的默认实现
public final class DefaultSuavisService: SuavisService {
    /// 共享实例
    public static let shared = DefaultSuavisService()
    
    /// 当前配置
    public let configuration: Configuration
    
    // 私有初始化方法，防止外部创建实例
    private init() {
        self.configuration = .default
    }
    
    public func greet(name: String) -> String {
        return "Hello, \(name)!"
    }
    
    public func fetchData() async throws -> String {
        // 模拟异步操作
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return "Data fetched successfully"
    }
}