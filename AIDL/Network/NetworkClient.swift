//
//  NetworkClient.swift
//  AIDL
//
//  Created by Jinyoung Kim on 9/16/25.
//

import Foundation

enum HTTPError: Error {
  case badRequest
  case badServerResponse
  case other
}

class NetworkClient {
  func request<T: HTTPEndpoint>(_ endpoint: T) async throws -> (data: T.Response, response: URLResponse) {
    let request = getRequest(endpoint)
    let (data, response) = try await URLSession.shared.data(for: request)
    printData(data)
    return try (JSONDecoder().decode(T.Response.self, from: data), response)
  }

  func requestValidated<T: HTTPEndpoint>(_ endpoint: T) async throws -> T.Response {
    let (data, response) = try await request(endpoint)
    let httpURLResponse = response as? HTTPURLResponse
    guard let httpURLResponse, (200 ..< 300).contains(httpURLResponse.statusCode) else {
      if httpURLResponse == nil {
        throw HTTPError.other
      } else {
        switch httpURLResponse!.statusCode {
        case 400 ..< 500:
          throw HTTPError.badRequest
        case 500 ..< 600:
          throw HTTPError.badServerResponse
        default:
          throw HTTPError.other
        }
      }
    }
    return data
  }

  private func printData(_ data: Data) {
    print("👀 NetworkClient --start")
    do {
      if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
        print(dict)
      }
    } catch {
      print("Failed to decode JSON:", error)
    }
    print("👀 NetworkClient --end")
  }

  private func getRequest<T: HTTPEndpoint>(_ endpoint: T) -> URLRequest {
    let url = getCompleteURL(endpoint)
    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.uppercased
    request.allHTTPHeaderFields = getHTTPHeaderFields(T.self, headers: endpoint.headers)
    request.httpBody = endpoint.body
    return request
  }

  private func getCompleteURL<T: HTTPEndpoint>(_ endpoint: T) -> URL {
    var url = endpoint.url
    url.append(path: endpoint.path)
    let queryItems = asQueryItems(T.self, query: endpoint.query)
    url.append(queryItems: queryItems)
    return url
  }

  private func getHTTPHeaderFields<T: HTTPEndpoint>(_: T.Type, headers: T.Header?) -> [String: String] {
    do {
      return try headers?.asKeyValues().mapValues { "\($0)" } ?? [:]
    } catch {
      print(#function, error)
      return [:]
    }
  }

  private func asQueryItems<T: HTTPEndpoint>(_: T.Type, query: T.Query?) -> [URLQueryItem] {
    do {
      return try query?.asKeyValues().map { key, value in
        URLQueryItem(name: key, value: "\(value)")
      } ?? []
    } catch {
      print(#function, error)
      return []
    }
  }
}

private extension Encodable {
  func asKeyValues() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
    return json ?? [:]
  }
}
