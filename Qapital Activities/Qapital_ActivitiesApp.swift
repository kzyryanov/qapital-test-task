//
//  Qapital_ActivitiesApp.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-14.
//

import SwiftUI

@main
struct Qapital_ActivitiesApp: App {
    private let activitiesViewModel = ActivitiesViewModel(APIService())
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: activitiesViewModel)
        }
    }
}
