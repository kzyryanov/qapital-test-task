//
//  ErrorView.swift
//  Qapital Activities UIKit
//
//  Created by Konstantin Zyrianov on 2021-09-16.
//

import UIKit

final class ErrorView: UIView {
    
    var retryAction: (()->())?
    
    static func fromNib() -> ErrorView {
        guard let view = Bundle.main.loadNibNamed("ErrorView", owner: nil, options: nil)?.first as? ErrorView else {
            fatalError("Cannot load ErrorView")
        }
        
        return view
    }
    
    @IBAction func retryButtonAction(_ sender: UIButton) {
        self.retryAction?()
    }
}
