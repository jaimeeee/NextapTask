//
//  StoryTests.swift
//  NextapTaskTests
//

import XCTest
import Nimble
@testable import NextapTask

class StoryTests: XCTestCase {

    // swiftlint:disable function_body_length line_length
    func testStoryDecode() {
        // Given
        let json = """
            {
              "id": "1639306299789281145",
              "short_id": "9mt4wWmaeW5",
              "revision": 3,
              "user": {
                "id": "76794126980351029",
                "revision": 76,
                "display_name": "Richard McAniff",
                "avatar_image_url": "https://d2rbodpj0xodc.cloudfront.net/users/76794126980351029/avatar/77154bf1-8645-444a-9d6c-c43c8d14363a.jpeg",
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
              },
              "version": 4,
              "cover_src": "https://d2rbodpj0xodc.cloudfront.net/stories/1639306299789281145/ed428a82-b310-48b1-bfcd-dd56513e23fb-640x960.jpeg",
              "cover_bg": "#B7BABF",
              "share_url": "https://steller.co/s/czech-republic-august-9mt4wWmaeW5",
              "landscape_share_image": "https://d2rbodpj0xodc.cloudfront.net/stories/1639306299789281145/d8a26d7b-fce0-4c08-83e1-71098def935c.jpeg",
              "feed_preview_video": null,
              "page_count": 5,
              "title": "CZECH REPUBLIC AUGUST 2019",
              "snippet": {
                "text": "",
                "entities": {
                  "hashtags": [],
                  "urls": [],
                  "users": []
                }
              },
              "collection_count": 2,
              "comment_count": 0,
              "canonical_pin": null,
              "aspect_ratio": "9:16",
              "story_type_id": null,
              "story_type": null,
              "amp_url": null,
              "cover_src_320x480": "https://d2rbodpj0xodc.cloudfront.net/stories/1639306299789281145/ed428a82-b310-48b1-bfcd-dd56513e23fb-320x480.jpeg",
              "cover_src_160x240": "https://d2rbodpj0xodc.cloudfront.net/stories/1639306299789281145/ed428a82-b310-48b1-bfcd-dd56513e23fb-160x240.jpeg",
              "likes": {
                "count": 270,
                "current_user": false
              },
              "private": false
            }
        """
        
        // When
        guard let jsonData = json.data(using: .utf8) else {
            fail()
            return
        }
        let story = try? JSONDecoder().decode(Story.self, from: jsonData)
        
        // Then
        expect(story).toNot(beNil())
        expect(story?.id).to(equal("1639306299789281145"))
        expect(story?.coverSrc).to(equal(URL(string: "https://d2rbodpj0xodc.cloudfront.net/stories/1639306299789281145/ed428a82-b310-48b1-bfcd-dd56513e23fb-640x960.jpeg")!))
    }

}
