//
//  UIColorTests.swift
//  NextapTaskTests
//

import XCTest
import Nimble
@testable import NextapTask

class UIColorTests: XCTestCase {

    func testHexColor() {
        // Given
        let scenarios: [(color: String, isNil: Bool)] = [
            (color: "#567BA0", isNil: false),
            (color: "#567BA000", isNil: true),
            (color: "nan", isNil: true)
        ]
        
        // When
        for scenario in scenarios {
            let color = UIColor(hex: scenario.color)
            
            // Then
            if scenario.isNil {
                expect(color).to(beNil())
            } else {
                expect(color).toNot(beNil())
            }
        }
    }

}
