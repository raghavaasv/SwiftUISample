//
//  AnimeView.swift
//  SwiftUIExample
//
//  Created by Sri on 1/21/21.
//

import Foundation

import SwiftUI

///  Struct: AnimeView
///  
///  Main View to render Search Bar and corresponding results
///
struct AnimeView: View {
  var body: some View {
    NavigationView {
      List {
        searchField

        if viewModel.dataSource.isEmpty {
          emptySection
        } else {
            loadSearchResultsSection
        }
      }
      .listStyle(GroupedListStyle())
      .navigationBarTitle("Anime Channels")
    }
  }
  
  /// Connects to AnimeViewModel to Capture Search Text
  @ObservedObject var viewModel: AnimeViewModel

  /// Intializer: Initizes the AnimeView with AnimeViewModel
  init(viewModel: AnimeViewModel) {
    self.viewModel = viewModel
  }
}

///  Extension: AnimeView
///  Main View to render Search Bar and corresponding results
///
private extension AnimeView {
  /// searchField Component
  var searchField: some View {
    HStack(alignment: .center) {
        TextField("e.g. naruto", text: $viewModel.query)
    }
  }

  /// List Component for Search Results
  var loadSearchResultsSection: some View {
    Section {
        ForEach(viewModel.dataSource, content: AnimeViewItem.init(viewModel:))
    }
  }

  /// Empty Component for Search Results
  var emptySection: some View {
    Section {
      Text("No results")
        .foregroundColor(.gray)
    }
  }
}
