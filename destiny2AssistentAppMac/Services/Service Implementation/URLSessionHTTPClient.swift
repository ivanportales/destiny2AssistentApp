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
        show(urlRequest: urlRequest)
        dataTask(with: urlRequest) {[weak self] data, response, error in
            completion(data, response as? HTTPResponseProtocol, error)
        }.resume()
    }
    
    private func show(urlRequest: URLRequest) {
        print("----------------------------------Request----------------------------------")
        print("HTTP Headers:")
        urlRequest.allHTTPHeaderFields?.forEach({ (key: String, value: String) in
            print("\(key): \(value)")
        })
        if let httpMethod = urlRequest.httpMethod {
            print("HTTP Method: \(httpMethod)")
        }
        if let url = urlRequest.url {
            print("URL: \(url)")
        }
        if let body = urlRequest.httpBody,
           let stringRepresentation = String(data: body, encoding: .utf8) {
            print("HTTP Body: \(stringRepresentation)")
        }
        print("----------------------------------End of Request----------------------------------")
    }
}
