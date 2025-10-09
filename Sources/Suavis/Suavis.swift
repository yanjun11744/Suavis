// Sources/Suavis/Suavis.swift

/// Suavis - 优雅的 Swift 工具库
public enum Suavis {
    // MARK: - 库信息
    public static let version = "1.0.0"
    public static let name = "Suavis"
    public static let author = "Your Name"
    
    // MARK: - 子模块命名空间
    public enum Network {}
    public enum Storage {}
    public enum Utils {}
    
    // MARK: - 初始化
    public static func initialize() {
        print("🎉 \(name) v\(version) 已初始化")
    }
}
