//
//  Test.swift
//  Suavis
//
//  Created by Yanjun Sun on 2025/10/12.
//

import Testing
@testable import Suavis

struct Test {

    @Test func isEmpty() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let result = StrUtil.isEmpty("")
        print(result)
    }

}
