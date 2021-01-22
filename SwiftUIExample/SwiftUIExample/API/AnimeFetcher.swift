//
//  AnimeFetcher.swift
//  SwiftUIExample
//
//  Created by Sri on 1/21/21.
//

import Foundation
import Combine

///  Protocol: AnimeFetchProtocol
///
///  Exposes Methods that Initiates the Search
///
protocol AnimeFetchProtocol {
    func getAnimeForSearch(
        query text: String
    ) -> AnyPublisher<AnimeResponseModel, ApiError>
}

///  Protocol: AnimeFetcher
///
///  Main API Class to make REST calls
///
class AnimeFetcher {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

///  Extension: AnimeFetcher
///
///  Confirms to  AnimeFetchProtocol for the Search API initiation
///
extension AnimeFetcher: AnimeFetchProtocol {
    func getAnimeForSearch(
        query text: String
    ) -> AnyPublisher<AnimeResponseModel, ApiError> {
      return processSearchRequest(forQuery: text)
    }
}

///  Extension: AnimeFetcher
///
///  Provides the services to process the Search using URLSession
///
private extension AnimeFetcher {
    ///  Struct: AnimeAPI
    ///
    ///  Provides the Endpoints, path and scheme
    ///
    struct AnimeAPI {
        static let scheme = "https"
        static let host = "api.jikan.moe"
        static let path = "/v3/search/anime"
    }
    
    ///  Function: AnimeFetcher
    ///
    ///  Contructs the URLComponents
    ///
    ///  Intiates Native URLSession and provides the response further decode
    func processSearchRequest<T>(
        forQuery text: String) -> AnyPublisher<T, ApiError> where T: Decodable {
        
        var components = URLComponents()
        components.scheme = AnimeAPI.scheme
        components.host = AnimeAPI.host
        components.path = AnimeAPI.path
        
        components.queryItems = [
          URLQueryItem(name: "q", value: text),
        ]

        guard let url = components.url else {
          let error = ApiError.network(description: "Something went wrong!")
          return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
}
