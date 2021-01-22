//
//  AnimeViewModel.swift
//  SwiftUIExample
//
//  Created by Sri on 1/21/21.
//

import Foundation
import Combine

///  Class: AnimeViewModel
///
///  Model handles the AnimeView Render and Initiates the Search
///
class AnimeViewModel: ObservableObject, Identifiable {
    
    /// query property that binds with AnimeView and AnimeViewModel
    @Published var query: String = ""

    /// dataSource property that the receives the search results
    @Published var dataSource: [AnimeItemViewModel] = []

    /// animeFetchHandler property that helps in trigger API the process of Search
    private let animeFetchHandler: AnimeFetcher

    /// Cancellable reference for the disposables set
    private var disposables = Set<AnyCancellable>()

    /// Intializer: Initizes the AnimeViewModel with Default scheduler
    init(
        animeFetchHandler: AnimeFetcher,
        scheduler: DispatchQueue = DispatchQueue(label: "AnimeViewModel")) {
        self.animeFetchHandler = animeFetchHandler
        /// Dropping the first empty string might happen initial load
        /// Also waiting for 1.5 seconds for typing text in search field
        $query.dropFirst().debounce(for: .seconds(1.5), scheduler: scheduler)
            .sink(receiveValue: getAnimeList(anime:))
            .store(in: &disposables)
    
    }
    
    /// Function: getAnimeList
    ///
    /// Params: anime, String value to Search
    ///
    /// Function intiates the Search by calling getAnimeForSearch:query
    ///
    /// Maps the response with AnimeItemViewModel Result Array
    ///
    /// Updates the UI by setting the DataSource
    func getAnimeList(anime value: String) {
        animeFetchHandler.getAnimeForSearch(query: value)
        .map { response in
          response.results.map(AnimeItemViewModel.init)
        }
        .receive(on: DispatchQueue.main)
        .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
              // 6
              self.dataSource = []
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] result in
            guard let self = self else { return }
            self.dataSource = result
        })
        .store(in: &disposables)
    }
}
