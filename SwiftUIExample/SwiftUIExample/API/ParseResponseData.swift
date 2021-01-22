//
//  ParseResponseData.swift
//  SwiftUIExample
//
//  Created by Sri on 1/21/21.
//

import Foundation
import Combine

// Mark: ApiError
/// Define API Possible Error
enum ApiError: Error {
  case parsing(description: String)
  case network(description: String)
}

// Mark: decode
/// Parses the data and then Publish for subscribers to capture.
func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, ApiError> {
  let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
