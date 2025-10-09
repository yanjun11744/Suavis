// Sources/Suavis/Main/SuavisService.swift

/// Suavis 核心服务协议
public protocol SuavisService: Sendable {
    /// 打招呼功能
    func greet(name: String) -> String
    
    /// 获取数据（异步）
    func fetchData() async throws -> String
    
    /// 当前配置
    var configuration: Configuration { get }
}