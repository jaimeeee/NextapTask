//
//  UserTests.swift
//  NextapTaskTests
//

import XCTest
import Nimble
@testable import NextapTask

class UserTests: XCTestCase {

    // swiftlint:disable line_length
    func testUserDecode() {
        // Given
        let json = """
            {
              "id": "76794126980351029",
              "revision": 76,
              "display_name": "Richard McAniff",
              "avatar_image_url":   "https://d2rbodpj0xodc.cloudfront.net/users/76794126980351029/avatar/77154bf1-8645-444a-9d6c-c43c8d14363a.jpeg",
              "avatar_image_bg": "#1F2835",
              "header_image_bg": "#948F8B",
              "followers": 2990,
              "following": 3971,
              "explicitly_followed": false,
              "implicitly_followed": false,
              "follows_you": false,
              "blocked": false,
              "stories": 29,
              "follow_request_sent": false,
              "follow_request_received": false,
              "_username": "mombo",
              "private": false
            }
        """
        
        // When
        guard let jsonData = json.data(using: .utf8) else {
            fail()
            return
        }
        let user = try? JSONDecoder().decode(User.self, from: jsonData)
        
        // Then
        expect(user).toNot(beNil())
        expect(user?.id).to(equal("76794126980351029"))
        expect(user?.displayName).to(equal("Richard McAniff"))
        expect(user?.avatarImageURL).to(equal(URL(string: "https://d2rbodpj0xodc.cloudfront.net/users/76794126980351029/avatar/77154bf1-8645-444a-9d6c-c43c8d14363a.jpeg")!))
    }

}
