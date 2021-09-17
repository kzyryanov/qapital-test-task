//
//  ErrorView.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-16.
//

import SwiftUI

struct ErrorView: View {
    var retryAction: ()->()
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Something went wrong...")
                .font(.body)
                .foregroundColor(.secondary)
            Button(action: {
                retryAction()
            }) {
                VStack {
                    Image(systemName: "arrow.counterclockwise.circle")
                    Text("Try again")
                }
                .foregroundColor(.primary)
                .padding()
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(retryAction: { })
    }
}
