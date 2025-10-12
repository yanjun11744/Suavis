//
//  HttpClient.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Foundation

/// HTTP客户端实现类
public final class HttpClientImpl {
    public static let shared = HttpClientImpl()
    
    private let session: URLSession
    private var defaultHeaders: [String: String] = [:]
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        self.session = URLSession(configuration: config)
    }
    
    /// 设置默认请求头
    public func setDefaultHeaders(_ headers: [String: String]) {
        self.defaultHeaders = headers
    }
    
    /// GET请求
    public func get(_ url: String, headers: [String: String]? = nil) async throws -> Data {
        return try await request(url: url, method: "GET", headers: headers)
    }
    
    /// POST请求
    public func post(_ url: String, body: Data? = nil, headers: [String: String]? = nil) async throws -> Data {
        return try await request(url: url, method: "POST", body: body, headers: headers)
    }
    
    private func request(url: String, method: String, body: Data? = nil, headers: [String: String]? = nil) async throws -> Data {
        guard let requestUrl = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method
        request.httpBody = body
        
        // 合并默认和自定义请求头
        defaultHeaders.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        let (data, _) = try await session.data(for: request)
        return data
    }
}

/// HTTP工具全局别名，可直接使用 HttpUtil.get()
public let HttpUtil = HttpClientImpl.shared
