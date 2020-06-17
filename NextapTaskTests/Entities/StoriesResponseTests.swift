//
//  StoriesResponseTests.swift
//  NextapTaskTests
//

import XCTest
import Nimble
@testable import NextapTask

class StoriesResponseTests: XCTestCase {

    func testStoriesResponseDecode() {
        // Given
        let json = """
            {
              "data": [],
              "cursor": {
                "before": "1639306299789281145",
                "after": "280364359924844106"
              }
            }
        """
        
        // When
        guard let jsonData = json.data(using: .utf8) else {
            fail()
            return
        }
        let storiesResponse = try? JSONDecoder().decode(StoriesResponse.self, from: jsonData)
        
        // Then
        expect(storiesResponse).toNot(beNil())
        expect(storiesResponse?.before).to(equal("1639306299789281145"))
        expect(storiesResponse?.after).to(equal("280364359924844106"))
    }

}
