//
//  ContentView.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ActivitiesViewModel
    
    var body: some View {
        NavigationView {
            ContainerView {
                switch viewModel.state {
                case .failed:
                    ErrorView {
                        viewModel.getActivities()
                    }
                case .loading where viewModel.activities.isEmpty:
                    ActivityIndicator(isAnimating: .constant(true), style: .medium)
                case .loading, .loaded:
                    ActivitiesView(viewModel: viewModel)
                case .none: ContainerView {}
                }
            }
            .navigationBarTitle(Text("Activities"), displayMode: .inline)
        }
        
        .onAppear(perform: {
            viewModel.getActivities()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let activitiesViewModel = ActivitiesViewModel(PreviewAPIService())
        ContentView(viewModel: activitiesViewModel)
    }
}
