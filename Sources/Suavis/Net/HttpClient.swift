//
//  HttpClient.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation

/// HTTP客户端配置
public struct HttpClientConfig: Sendable {
    public let baseURL: String?
    public let defaultHeaders: [String: String]
    public let timeout: TimeInterval
    public let cachePolicy: URLRequest.CachePolicy
    
    public init(
        baseURL: String? = nil,
        defaultHeaders: [String: String] = [:],
        timeout: TimeInterval = 30,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    ) {
        self.baseURL = baseURL
        self.defaultHeaders = defaultHeaders
        self.timeout = timeout
        self.cachePolicy = cachePolicy
    }
}

/// HTTP请求结果
public struct HttpResponse: Sendable {
    public let data: Data
    public let statusCode: Int
    public let headers: [String: String]
    
    public init(data: Data, statusCode: Int, headers: [String: String]) {
        self.data = data
        self.statusCode = statusCode
        self.headers = headers
    }
}

/// HTTP客户端实现类
public final class HttpClient: Sendable {
    private let session: URLSession
    public let config: HttpClientConfig
    
    /// 创建新的 HTTP 客户端实例
    public init(config: HttpClientConfig = HttpClientConfig()) {
        self.config = config
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = config.timeout
        configuration.httpAdditionalHeaders = config.defaultHeaders
        self.session = URLSession(configuration: configuration)
    }
    
    // MARK: - 配置方法
    
    /// 创建带新配置的客户端实例
    public func withConfig(_ newConfig: HttpClientConfig) -> HttpClient {
        return HttpClient(config: newConfig)
    }
    
    /// 创建带基础URL的客户端实例
    public func withBaseURL(_ baseURL: String) -> HttpClient {
        let newConfig = HttpClientConfig(
            baseURL: baseURL,
            defaultHeaders: config.defaultHeaders,
            timeout: config.timeout,
            cachePolicy: config.cachePolicy
        )
        return HttpClient(config: newConfig)
    }
    
    /// 创建带新请求头的客户端实例
    public func withHeaders(_ headers: [String: String]) -> HttpClient {
        let newConfig = HttpClientConfig(
            baseURL: config.baseURL,
            defaultHeaders: headers,
            timeout: config.timeout,
            cachePolicy: config.cachePolicy
        )
        return HttpClient(config: newConfig)
    }
    
    /// 添加请求头（合并到现有头）
    public func addingHeaders(_ headers: [String: String]) -> HttpClient {
        var mergedHeaders = config.defaultHeaders
        headers.forEach { mergedHeaders[$0.key] = $0.value }
        
        let newConfig = HttpClientConfig(
            baseURL: config.baseURL,
            defaultHeaders: mergedHeaders,
            timeout: config.timeout,
            cachePolicy: config.cachePolicy
        )
        return HttpClient(config: newConfig)
    }
    
    /// 创建带新超时时间的客户端实例
    public func withTimeout(_ timeout: TimeInterval) -> HttpClient {
        let newConfig = HttpClientConfig(
            baseURL: config.baseURL,
            defaultHeaders: config.defaultHeaders,
            timeout: timeout,
            cachePolicy: config.cachePolicy
        )
        return HttpClient(config: newConfig)
    }
    
    // MARK: - HTTP 方法
    
    /// GET请求
    public func get(_ path: String, headers: [String: String]? = nil) async throws -> HttpResponse {
        return try await request(path: path, method: "GET", headers: headers)
    }
    
    /// POST请求
    public func post(_ path: String, body: Data? = nil, headers: [String: String]? = nil) async throws -> HttpResponse {
        return try await request(path: path, method: "POST", body: body, headers: headers)
    }
    
    /// PUT请求
    public func put(_ path: String, body: Data? = nil, headers: [String: String]? = nil) async throws -> HttpResponse {
        return try await request(path: path, method: "PUT", body: body, headers: headers)
    }
    
    /// DELETE请求
    public func delete(_ path: String, headers: [String: String]? = nil) async throws -> HttpResponse {
        return try await request(path: path, method: "DELETE", headers: headers)
    }
    
    /// PATCH请求
    public func patch(_ path: String, body: Data? = nil, headers: [String: String]? = nil) async throws -> HttpResponse {
        return try await request(path: path, method: "PATCH", body: body, headers: headers)
    }
    
    // MARK: - 核心请求方法
    
    private func request(path: String, method: String, body: Data? = nil, headers: [String: String]? = nil) async throws -> HttpResponse {
        let urlString = buildURL(path: path)
        guard let requestUrl = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method
        request.httpBody = body
        request.cachePolicy = config.cachePolicy
        
        // 设置请求头
        config.defaultHeaders.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        // 提取响应头
        var responseHeaders: [String: String] = [:]
        if let headers = httpResponse.allHeaderFields as? [String: String] {
            responseHeaders = headers
        }
        
        return HttpResponse(
            data: data,
            statusCode: httpResponse.statusCode,
            headers: responseHeaders
        )
    }
    
    private func buildURL(path: String) -> String {
        if let baseURL = config.baseURL {
            if baseURL.hasSuffix("/") && path.hasPrefix("/") {
                return baseURL + String(path.dropFirst())
            } else if !baseURL.hasSuffix("/") && !path.hasPrefix("/") {
                return baseURL + "/" + path
            } else {
                return baseURL + path
            }
        }
        return path
    }
    
    // MARK: - 便捷方法
    
    /// 带 JSON 体的 POST 请求
    public func postJSON(_ path: String, json: [String: Any], headers: [String: String]? = nil) async throws -> HttpResponse {
        let jsonData = try JSONSerialization.data(withJSONObject: json)
        var mergedHeaders = headers ?? [:]
        mergedHeaders["Content-Type"] = "application/json"
        return try await post(path, body: jsonData, headers: mergedHeaders)
    }
    
    /// 带 JSON 体的 PUT 请求
    public func putJSON(_ path: String, json: [String: Any], headers: [String: String]? = nil) async throws -> HttpResponse {
        let jsonData = try JSONSerialization.data(withJSONObject: json)
        var mergedHeaders = headers ?? [:]
        mergedHeaders["Content-Type"] = "application/json"
        return try await put(path, body: jsonData, headers: mergedHeaders)
    }
    
    /// 带表单数据的 POST 请求
    public func postForm(_ path: String, formData: [String: String], headers: [String: String]? = nil) async throws -> HttpResponse {
        var mergedHeaders = headers ?? [:]
        mergedHeaders["Content-Type"] = "application/x-www-form-urlencoded"
        
        let formString = formData.map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" }
            .joined(separator: "&")
        
        let formData = formString.data(using: .utf8)
        return try await post(path, body: formData, headers: mergedHeaders)
    }
    
    /// 下载文件
    public func download(_ path: String, headers: [String: String]? = nil) async throws -> (Data, URLResponse) {
        let urlString = buildURL(path: path)
        guard let requestUrl = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: requestUrl)
        config.defaultHeaders.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        return try await session.data(for: request)
    }
}

// MARK: - 默认实例和便捷别名

/// 默认的 HTTP 客户端实例
public let HttpUtil = HttpClient()

/// 创建特定 API 的客户端
public extension HttpClient {
    /// 创建 GitHub API 客户端
    static func github() -> HttpClient {
        return HttpClient(config: HttpClientConfig(
            baseURL: "https://api.github.com",
            defaultHeaders: [
                "Accept": "application/vnd.github.v3+json",
                "User-Agent": "Suavis-HttpClient"
            ]
        ))
    }
    
    /// 创建 JSONPlaceholder API 客户端
    static func jsonPlaceholder() -> HttpClient {
        return HttpClient(config: HttpClientConfig(
            baseURL: "https://jsonplaceholder.typicode.com",
            defaultHeaders: [
                "Content-Type": "application/json"
            ]
        ))
    }
}
