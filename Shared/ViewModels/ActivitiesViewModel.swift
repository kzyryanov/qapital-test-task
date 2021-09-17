//
//  ActivitiesViewModel.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import Foundation
import Combine

final class ActivitiesViewModel: ObservableObject {
    enum State {
        case loading
        case failed
        case loaded
        case none
    }
    
    private(set) var activities: [ActivityViewModel] = []
    private(set) var hasMore: Bool = true
    @Published var state: State = .none
    
    var activitiesSubscription: AnyCancellable?
    
    private var toDate: Date
    private var fromDate: Date
    
    private var oldest: Date?
    
    private static let twoWeeksInterval: TimeInterval = 14 * 24 * 60 * 60
    
    private let service: Service
    
    init(_ service: Service) {
        self.service = service
        
        let toDate = Date()
        
        self.toDate = toDate
        self.fromDate = toDate.addingTimeInterval(-ActivitiesViewModel.twoWeeksInterval)
    }
}

extension ActivitiesViewModel {
    func getActivities() {
        guard self.state != .loading else {
            return
        }
        self.state = .loading
        activitiesSubscription = self.getActivities()
    }
    
    private func getActivities() -> AnyCancellable {
        return service.activities(from: fromDate, to: toDate)
            .sink(receiveCompletion: { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure: self?.state = .failed
                    case .finished: self?.state = .loaded
                    }
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                self.oldest = response.oldest
                if !response.activities.isEmpty {
                    self.activities += response.activities.map({ ActivityViewModel($0, service: self.service) })
                }
                
                guard response.oldest < self.fromDate else {
                    self.hasMore = false
                    return
                }
                
                self.fromDate = self.fromDate.addingTimeInterval(-ActivitiesViewModel.twoWeeksInterval)
                self.toDate = self.toDate.addingTimeInterval(-ActivitiesViewModel.twoWeeksInterval)
                
                if response.activities.isEmpty {
                    self.activitiesSubscription = self.getActivities()
                }
            })
    }
}
