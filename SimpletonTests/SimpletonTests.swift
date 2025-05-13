//
//  SimpletonTests.swift
//  SimpletonTests
//
//  Created by Paula Vasconcelos Gueiros on 04/04/25.
//

import Testing
@testable import Simpleton

struct SimpletonTests {
    
    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        
        let a = 5
        #expect(a == 5)
    }

}
