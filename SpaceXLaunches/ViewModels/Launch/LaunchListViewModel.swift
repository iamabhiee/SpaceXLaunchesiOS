//
//  LaunchesViewModel.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 28/03/21.
//

import Foundation
import RxSwift

public class LaunchListViewModel {
    let title = "Launches"
    
    private let launchService : LaunchServiceProtocol
    private var launches: [Launch] = []

    
    init(service : LaunchServiceProtocol = LaunchService()) {
        self.launchService = service
    }
    
    func fetchLaunchViewModel() -> Observable<[LaunchViewModel]> {
        return launchService.fetchLaunches().do(onNext: { [weak self] launches in
            self?.launches = launches
        }).map({ $0.map {
            LaunchViewModel(launch: $0)
        } })
    }
    
    func rocketId(at index : Int) -> String {
        return self.launches[index].rocket ?? ""
    }
}
