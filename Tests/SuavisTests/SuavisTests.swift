import Testing
@testable import Suavis

struct SuavisTests {
    
    // MARK: - 同步方法测试
    
    @Test func testGreet() {
        let result = Suavis.greet(name: "World")
        print(result)
        #expect(result == "Hello, World!")
    }
    
    // MARK: - 异步方法测试
    
    @Test func testFetchData() async throws {
        let result = try await Suavis.fetchData()
        print(result)
        #expect(result == "Data fetched successfully")
    }
}
