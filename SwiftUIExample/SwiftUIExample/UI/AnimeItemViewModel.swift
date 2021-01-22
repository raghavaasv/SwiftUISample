//
//  AnimeItemViewModel.swift
//  SwiftUIExample
//
//  Created by Sri on 1/21/21.
//

import Foundation
import SwiftUI

///  Class: AnimeItemViewModel
///
///  Model handles the AnimeViewItem Render upon receiving the serach results
///
struct AnimeItemViewModel: Identifiable {
    let id = UUID()
    
    private let item: AnimeResponseModel.Result
    
    var title: String {
        return item.title
    }
    
    var synopsis: String {
        return item.synopsis
    }
    
    var malId: Int {
        return item.malId
    }
    
    var url: String {
      return item.url
    }

    var imageUrl: String {
        return item.imageUrl
    }
    
    var rated: String {
        return item.rated ?? ""
    }

    /// Intializer: Initizes the AnimeItemViewModel with corresponding AnimeResponseModel Result
    init(item: AnimeResponseModel.Result) {
      self.item = item
    }
}
