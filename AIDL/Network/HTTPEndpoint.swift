import Foundation

protocol HTTPEndpoint {
  associatedtype Query: Encodable
  associatedtype Header: Encodable
  associatedtype Response: Decodable

  var url: URL { get }
  var method: HTTPMethod { get }
  var headers: Header? { get }
  var query: Query? { get }
  var body: Data? { get }
}

enum HTTPMethod: String {
  case get
  case post
  case put
  case patch
  case delete

  var uppercased: String {
    return rawValue.uppercased()
  }
}
