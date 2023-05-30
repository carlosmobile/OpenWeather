//
//  MockAPIClient.swift
//  OpenWeatherTests
//
//  Created by Carlos on 30/5/23.
//

import Foundation
@testable import OpenWeather

typealias APIClientCompletion = (APIResult<Data?>) -> Void

class MockAPIClient: APIClientProtocol {

    var expectedResult: Result<APIResponse<Data?>, APIError>?

    func perform(
        request: APIRequest,
        completion: @escaping APIClientCompletion
    ) {
        guard let result = self.expectedResult else { return }

        switch result {
        case .success(let data):
            completion(.success(data))
        case .failure(let apiError):
            completion(.failure(apiError))
        }
    }
}
