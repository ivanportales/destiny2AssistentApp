//
//  URLSessionHTTPClient.swift
//  destiny2AssistentApp
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/22.
//

import Foundation

protocol HTTPClientProtocol {
    func makeRequest(to urlRequest: URLRequest,
                     completion: @escaping (Data?, HTTPResponseProtocol?, Error?) -> Void)
}

extension URLSession: HTTPClientProtocol {
    func makeRequest(to urlRequest: URLRequest, completion: @escaping (Data?, HTTPResponseProtocol?, Error?) -> Void) {
        dataTask(with: urlRequest) { data, response, error in
            print(String(data: data!, encoding: .utf8))
            completion(data, response as? HTTPResponseProtocol, error)
        }.resume()
    }
}
