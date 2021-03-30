//
//  RocketDetailsViewModel.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 28/03/21.
//

import Foundation
import RxSwift

protocol RocketDetailsViewModelProtocol {
    var title : String { get }
    var images : PublishSubject<[String]> { get set }
    
    func fetchRocketViewModel() -> Observable<RocketViewModel>
    func didTapMoreDetails()
}

public class RocketDetailsViewModel {
    var title = "Launches"
    
    let rocketId : String!
    var rocketDetails : Rocket!
    var images : PublishSubject<[String]> = PublishSubject()
    
    private let rocketService : RocketServiceProtocol
    weak var coordinator : AppCoordinatorProtocol?
    
    
    init(rocketId : String, service : RocketServiceProtocol = RocketService(), coordinator : AppCoordinatorProtocol?) {
        self.rocketId = rocketId
        self.rocketService = service
        self.coordinator = coordinator
    }
}

extension RocketDetailsViewModel : RocketDetailsViewModelProtocol {
    func fetchRocketViewModel() -> Observable<RocketViewModel> {
        return rocketService.fetchLaunches(rocketId: self.rocketId).do(onNext: { (details) in
            self.rocketDetails = details
            let images = details.flickr_images ?? []
            self.images.onNext(images)
        }).map({ RocketViewModel(with: $0) })
    }
    
    func didTapMoreDetails() {
        self.coordinator?.openExternalURL(url: self.rocketDetails.wikipedia)
    }
}
