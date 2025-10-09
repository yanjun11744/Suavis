// Sources/Suavis/Suavis.swift

/// Suavis - 优雅的 Swift 工具库
///
/// # 简介
/// 一个设计精美的 Swift 库，提供简洁的 API 和强大的功能。
public enum Suavis {
    // MARK: - 库信息
    
    /// 库版本号
    public static let version = "1.0.0"
    
    /// 库名称
    public static let name = "Suavis"
    
    /// 作者信息
    public static let author = "Your Name"
    
    // MARK: - 服务实例
    
    private static let service: SuavisService = DefaultSuavisService.shared
    
    // MARK: - 公开 API
    
    /// 打招呼功能
    /// - Parameter name: 名称
    /// - Returns: 问候语
    public static func greet(name: String) -> String {
        return service.greet(name: name)
    }
    
    /// 获取数据（异步）
    /// - Returns: 获取的数据
    public static func fetchData() async throws -> String {
        return try await service.fetchData()
    }
    
    /// 当前配置
    public static var configuration: Configuration {
        return service.configuration
    }
    
    /// 初始化库
    public static func initialize() {
        print("🎉 \(name) v\(version) 已初始化")
    }
}
