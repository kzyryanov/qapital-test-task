//
//  ActivitiesView.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import SwiftUI

struct ActivitiesView: View {
    @ObservedObject var viewModel: ActivitiesViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.activities) { activity in
                ActivityView(viewModel: activity)
            }
            .listRowInsets(EdgeInsets())
            if viewModel.hasMore {
                HStack {
                    Spacer()
                    ActivityIndicator(isAnimating: .constant(true), style: .medium)
                        .onAppear(perform: {
                            viewModel.getActivities()
                        })
                    Spacer()
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ActivitiesViewModel(PreviewAPIService())
        
        ActivitiesView(viewModel: viewModel)
    }
}
