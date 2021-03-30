//
//  LaunchesViewModel.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 28/03/21.
//

import Foundation
import RxSwift

protocol LaunchListViewModelProtocol {
    var title : String { get }
    
    func fetchLaunchViewModel() -> Observable<[LaunchViewModel]>
    func rocketId(at index : Int) -> String
    func launchSelected(at indexPath : IndexPath)
}

public class LaunchListViewModel {
    var title = "Launches"
    
    private let launchService : LaunchServiceProtocol
    private var launches: [Launch] = []
    weak var coordinator : AppCoordinatorProtocol?
    
    init(service : LaunchServiceProtocol = LaunchService(), coordinator : AppCoordinatorProtocol?) {
        self.launchService = service
        self.coordinator = coordinator
    }
}

extension LaunchListViewModel : LaunchListViewModelProtocol {
    func fetchLaunchViewModel() -> Observable<[LaunchViewModel]> {
        return launchService.fetchLaunches().do(onNext: { [weak self] launches in
            self?.launches = launches
        }).map({ $0.map {
            LaunchViewModel(launch: $0)
        } })
    }
    
    func launchSelected(at indexPath : IndexPath) {
        let rocketId = self.rocketId(at: indexPath.row)
        self.coordinator?.redirectToDetails(for: rocketId)
    }
    
    func rocketId(at index : Int) -> String {
        return self.launches[index].rocket ?? ""
    }
}
