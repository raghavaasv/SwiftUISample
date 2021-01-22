//
//  SwiftUIExampleApp.swift
//  SwiftUIExample
//
//  Created by Sri on 1/21/21.
//
import Foundation
import SwiftUI

@main
struct SwiftUIExampleApp: App {
    var body: some Scene {
        WindowGroup {
            AnimeView(viewModel: AnimeViewModel(animeFetchHandler: AnimeFetcher()))
        }
    }
}
