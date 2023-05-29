//
//  TestAPIClient.swift
//  OpenWeatherTests
//
//  Created by Carlos on 30/5/23.
//

import XCTest

import XCTest
@testable import OpenWeather

class TestsAPIClient: XCTestCase {

    typealias APIClientCompletion = (APIResult<Data?>) -> Void

    var sut: APIClient!
    var apiResult: APIResult<Data?>?
    var response: APIResponse<Data?>?
    var completion: APIClientCompletion!

    override func setUpWithError() throws {
        self.apiResult = nil
        completion = { res in
            self.apiResult = res
        }
    }

    func testSuccessFullRequestSession() throws {
        let session = MockSession()
        session.expectedData = "expectedData".data(using: .utf8)
        session.expectedError = APIError.requestFailed
        session.expectedUrlResponse = HTTPURLResponse(url: URL(string: "http://testdata.com")!,
                                                      statusCode: 200,
                                                      httpVersion: nil,
                                                      headerFields: [:])

        sut = APIClient(session: session)

        let getRequest = APIRequest(method: .get, path: "http://testdata.com")

        sut.perform(request: getRequest) { result in
            self.apiResult = result
            switch result {
            case .success(let response):
                self.response = response
                XCTAssert(self.response?.statusCode == 200)
                print(self.response?.body as Any)
            case .failure:
                XCTAssert(false)
            }
        }
    }

    func testSuccessFullRequestClient() throws {
        let client = MockAPIClient()
        let getMockRequest = APIRequest(method: .get, path: "http://testdata.com")
        client.perform(request: getMockRequest) { resultData in
            switch resultData {
            case .success(let response):
                XCTAssert(response.statusCode == 200)
                XCTAssertNotNil(response.body, "empty body")
            case .failure:
                XCTAssert(false)
            }
        }
    }
}
