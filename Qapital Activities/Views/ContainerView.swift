//
//  ContainerView.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    var content: ()->Content
    
    init(@ViewBuilder content: @escaping ()->Content) {
        self.content = content
    }
    
    var body: some View {
        content()
    }
}
