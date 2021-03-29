//
//  RocketDetailsViewModel.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 28/03/21.
//

import Foundation
import RxSwift

public class RocketDetailsViewModel {
    let title = "Launches"
    
    let rocketId : String!
    private let rocketService : RocketServiceProtocol
    var rocketDetails : RocketDetailsViewModel!
    var images : PublishSubject<[String]> = PublishSubject()
    
    init(rocketId : String, service : RocketServiceProtocol = RocketService()) {
        self.rocketId = rocketId
        self.rocketService = service
    }
    
    func fetchRocketViewModel() -> Observable<RocketViewModel> {
        return rocketService.fetchLaunches(rocketId: self.rocketId).do(onNext: { (details) in
            let images = details.flickr_images ?? []
            self.images.onNext(images)
        }).map({ RocketViewModel(with: $0) })
    }
}
