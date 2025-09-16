//
//  Environment.swift
//  AIDL
//
//  Created by Assistant on 9/16/25.
//

import Foundation

enum Environment {
  // MARK: - Keys

  enum Keys {
    enum Plist {
      static let baseURL = "BASE_URL"
      static let apiToken = "API_TOKEN"
    }
  }

  // MARK: - Plist

  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()

  // MARK: - Plist values

  static let baseURL: URL = {
    guard let baseURLstring = Environment.infoDictionary[Keys.Plist.baseURL] as? String else {
      fatalError("Base URL not set in plist for this environment")
    }
    guard let url = URL(string: baseURLstring) else {
      fatalError("Base URL is invalid")
    }
    return url
  }()

  static let apiToken: String = {
    guard let apiToken = Environment.infoDictionary[Keys.Plist.apiToken] as? String else {
      fatalError("API Token not set in plist for this environment")
    }
    return apiToken
  }()
}
