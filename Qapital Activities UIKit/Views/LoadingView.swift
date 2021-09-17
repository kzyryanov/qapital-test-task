//
//  LoadingView.swift
//  Qapital Activities UIKit
//
//  Created by Konstantin Zyrianov on 2021-09-16.
//

import UIKit

final class LoadingView: UIView {
    static func fromNib() -> LoadingView {
        guard let view = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)?.first as? LoadingView else {
            fatalError("Cannot load LoadingView")
        }
        
        return view
    }
}
