//
//  ActivityView.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import SwiftUI
import Combine

struct ActivityView: View {
    @ObservedObject var viewModel: ActivityViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 8.0) {
            (viewModel.avatar.map { Image(uiImage: $0) } ?? Image(systemName: "person.crop.circle"))
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 32, height: 32)
                .clipShape(Circle())
                .padding(4)
            VStack(alignment: .leading, spacing: 8.0) {
                Text(viewModel.message)
                Text(viewModel.date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(viewModel.amount)
                .foregroundColor(Color(hex: "58BF0A"))
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 20))
        .onAppear(perform: {
            viewModel.fetchAvatar()
        })
        .onDisappear(perform: {
            viewModel.cancelFetchingAvatar()
        })
        
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity(message: "<strong>You</strong> didn't resist a guilty pleasure at <strong>Starbucks</strong>.",
                                amount: 2.5,
                                userId: 2,
                                timestamp: DateHelper.date(from: "2016-10-04T00:00:00+00:00")!)
        let viewModel = ActivityViewModel(activity, service: PreviewAPIService())
        ActivityView(viewModel: viewModel)
    }
}
