//
//  AnimeViewItem.swift
//  SwiftUIExample
//
//  Created by Sri on 1/22/21.
//

import Foundation
import SwiftUI
///  Struct: AnimeViewItem
///  
///  Renders the Anime Information in Horizantal Stack
///
struct AnimeViewItem: View {
    /// Property that connects to Model Data to show on View
    private let viewModel: AnimeItemViewModel
    
    /// Intializer: Initizes the AnimeViewItem with corresponding AnimeItemViewModel
    init(viewModel: AnimeItemViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack {
                // Loading Image needs more Work
                //  TODO: using the Native URLSession, the get image Data and pass to this view
                Image("\(viewModel.imageUrl)")
            }
            
            VStack(alignment: .leading) {
              Text("\(viewModel.title)")
                .font(.body)
              Text("\(viewModel.rated)")
                .font(.footnote)
            }
              .padding(.leading, 8)

            Spacer()

            Text("")
              .font(.title)
        }
    }
}
