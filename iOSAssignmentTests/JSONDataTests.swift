//
//  JSONDataTests.swift
//  iOSAssignmentTests
//
//  Created by Neelam Gupta on 02/02/20.
//  Copyright © 2020 Neelam Gupta. All rights reserved.
//

import XCTest
//@testable import iOSAssignmentTests

class JSONDataTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testJSONData() {
        guard let jsonUrl = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else { return }
        let promise = expectation(description: "Simple Request")
        URLSession.shared.dataTask(with: jsonUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let result = json as? NSDictionary {
                    print("result", result)
                    XCTAssertTrue(true)
                    promise.fulfill()
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
