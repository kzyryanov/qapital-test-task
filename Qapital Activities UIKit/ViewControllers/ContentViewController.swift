//
//  ContentViewController.swift
//  Qapital Activities UIKit
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import UIKit
import Combine

final class ContentViewController: UIViewController {
    
    private let viewModel: ActivitiesViewModel
    
    private var stateSubscription: AnyCancellable?
    
    private lazy var errorView: UIView = {
        let view = ErrorView.fromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.retryAction = { [weak self] in
            self?.viewModel.getActivities()
        }
        return view
    }()
    private lazy var loadingView: UIView = {
        let view = LoadingView.fromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var activitiesViewController: UIViewController = ActivitiesViewController(activitiesViewModel: viewModel)
    
    private var currentState: ActivitiesViewModel.State
    private var animator: UIViewPropertyAnimator?
    
    init(viewModel: ActivitiesViewModel) {
        self.viewModel = viewModel
        self.currentState = viewModel.state
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Activities"
        
        self.stateSubscription = viewModel.$state.sink(receiveValue: { [weak self] state in
            guard let self = self else { return }
            guard self.currentState != state else { return }
            
            switch state {
            case .failed: self.setFailedState()
            case .loading where self.viewModel.activities.isEmpty:
                self.setLoadingState(animated: self.currentState != .none)
            case .loaded, .loading: self.setListState()
            case .none: break
            }
            
            self.currentState = state
        })
        
        add(activitiesViewController, frame: view.bounds)
        
        self.view.addSubview(self.errorView)
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        self.errorView.isHidden = true
        
        self.view.addSubview(self.loadingView)
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        self.loadingView.isHidden = true
        
        self.viewModel.getActivities()
    }

    private func setFailedState() {
        self.errorView.alpha = 0.0
        self.errorView.isHidden = false
        
        self.animator?.stopAnimation(true)
        self.animator = UIViewPropertyAnimator(
            duration: 0.25,
            curve: .easeIn,
            animations: {
                self.errorView.alpha = 1.0
                self.loadingView.alpha = 0.0
            })
        self.animator?.addCompletion({_ in
            self.loadingView.isHidden = true
        })
        self.animator?.startAnimation()
    }
    
    private func setLoadingState(animated: Bool) {
        self.loadingView.alpha = 0.0
        self.loadingView.isHidden = false
        
        self.animator?.stopAnimation(true)
        self.animator = UIViewPropertyAnimator(
            duration: 0.25 * (animated ? 1.0 : 0.0),
            curve: .easeIn,
            animations: {
                self.errorView.alpha = 0.0
                self.loadingView.alpha = 1.0
            })
        self.animator?.addCompletion({_ in
            self.errorView.isHidden = true
        })
        self.animator?.startAnimation()
    }
    
    private func setListState() {
        self.animator?.stopAnimation(true)
        self.animator = UIViewPropertyAnimator(
            duration: 0.25,
            curve: .easeIn,
            animations: {
                self.errorView.alpha = 0.0
                self.loadingView.alpha = 0.0
            })
        self.animator?.addCompletion({_ in
            self.loadingView.isHidden = true
            self.errorView.isHidden = true
        })
        self.animator?.startAnimation()
    }
}

