//
//  APIClient.swift
//  OpenWeather
//
//  Created by Carlos on 27/5/23.
//

import Foundation

enum APIResult<Body> {
    case success(APIResponse<Body>)
    case failure(APIError)
}

typealias APIClientCompletion = (APIResult<Data?>) -> Void

protocol APIClientProtocol {
    func perform(
        request: APIRequest,
        completion: @escaping APIClientCompletion
    )
}

class APIClient {

    private let session: SessionProtocol

    // MARK: - Lifecycle

    convenience init() {
        self.init(session: URLSession.shared)
    }

    init(session: SessionProtocol) {
        self.session = session
    }

    func perform(
        request: APIRequest,
        completion: @escaping APIClientCompletion) {

        guard let url = URL(string: request.path) else {
            completion(.failure(.invalidURL))
            return
        }

        #if DEBUG
            print(url)
        #endif

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            guard let data = data else { return }
            if let jsonResponse = (try? JSONSerialization.jsonObject(with: data, options: [])) as? NSDictionary {
                #if DEBUG
                print(jsonResponse)
                #endif
            }
            completion(.success(APIResponse<Data?>(statusCode: httpResponse.statusCode, body: data)))
        }
        task.resume()
    }
}

