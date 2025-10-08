import Testing
@testable import Suavis

struct SuavisTests {
    
    // MARK: - 初始化测试
    
    @Test func testDefaultInitialization() {
        let suavis = Suavis()
        #expect(suavis.configuration.apiKey == "")
        #expect(suavis.configuration.environment == .development)
    }
    
    @Test func testCustomConfiguration() {
        let config = Configuration(apiKey: "test-api-key", environment: .production)
        let suavis = Suavis(configuration: config)
        
        #expect(suavis.configuration.apiKey == "test-api-key")
        #expect(suavis.configuration.environment == .production)
    }
    
    // MARK: - 同步方法测试
    
    @Test func testGreet() {
        let suavis = Suavis()
        let result = suavis.greet(name: "World")
        print(result)
        #expect(result == "Hello, World!")
    }
    
    // MARK: - 异步方法测试
    
    @Test func testFetchData() async throws {
        let suavis = Suavis()
        let result = try await suavis.fetchData()
        print(result)
        #expect(result == "Data fetched successfully")
    }
    
    @Test func testFetchDataExecutionTime() async throws {
        let suavis = Suavis()
        let startTime = ContinuousClock().now
        
        _ = try await suavis.fetchData()
        
        let endTime = ContinuousClock().now
        let duration = endTime - startTime
        
        // 验证异步操作大约需要1秒（考虑一些误差）
        #expect(duration >= .seconds(0.9))
        #expect(duration <= .seconds(2.0))
    }
    
    // MARK: - 配置测试
    
    @Test func testConfigurationDefault() {
        let defaultConfig = Configuration.default
        #expect(defaultConfig.apiKey == "")
        #expect(defaultConfig.environment == .development)
    }
    
    @Test func testConfigurationInitialization() {
        let config = Configuration(apiKey: "custom-key", environment: .production)
        #expect(config.apiKey == "custom-key")
        #expect(config.environment == .production)
    }
    
    @Test func testEnvironmentCases() {
        #expect(Environment.development != .production)
    }
    
    // MARK: - 边界条件测试
    
    @Test func testLongName() {
        let suavis = Suavis()
        let longName = String(repeating: "A", count: 1000)
        let result = suavis.greet(name: longName)
        #expect(result == "Hello, \(longName)!")
    }
    
    @Test func testUnicodeCharacters() {
        let suavis = Suavis()
        let emojiName = "👨‍💻 Swift Developer 🚀"
        let result = suavis.greet(name: emojiName)
        #expect(result == "Hello, \(emojiName)!")
    }
    
    @Test func testMultipleInstances() {
        let config1 = Configuration(apiKey: "key1", environment: .development)
        let config2 = Configuration(apiKey: "key2", environment: .production)
        
        let suavis1 = Suavis(configuration: config1)
        let suavis2 = Suavis(configuration: config2)
        
        #expect(suavis1.configuration.apiKey == "key1")
        #expect(suavis2.configuration.apiKey == "key2")
        #expect(suavis1.configuration.environment == .development)
        #expect(suavis2.configuration.environment == .production)
    }
    
    // MARK: - 并发测试
    
    @Test func testConcurrentGreetCalls() async {
        let suavis = Suavis()
        
        async let call1: String = suavis.greet(name: "User1")
        async let call2: String = suavis.greet(name: "User2")
        async let call3: String = suavis.greet(name: "User3")
        
        let results = await [call1, call2, call3]
        
        #expect(results == [
            "Hello, User1!",
            "Hello, User2!",
            "Hello, User3!"
        ])
    }
    
    @Test func testConcurrentFetchData() async throws {
        let suavis = Suavis()
        
        async let fetch1: String = try suavis.fetchData()
        async let fetch2: String = try suavis.fetchData()
        
        let results = try await [fetch1, fetch2]
        
        #expect(results.allSatisfy { $0 == "Data fetched successfully" })
    }
    
    // MARK: - 参数化测试示例
    
    @Test("Greet with various names", arguments: [
        "Alice", "Bob", "Charlie", "Diana"
    ])
    func testGreetWithVariousNames(name: String) {
        let suavis = Suavis()
        let result = suavis.greet(name: name)
        #expect(result == "Hello, \(name)!")
    }
    
    @Test("Configuration with different environments", arguments: [
        Environment.development,
        Environment.production
    ])
    func testConfigurationWithDifferentEnvironments(environment: Environment) {
        let config = Configuration(apiKey: "test-key", environment: environment)
        let suavis = Suavis(configuration: config)
        #expect(suavis.configuration.environment == environment)
    }
}
