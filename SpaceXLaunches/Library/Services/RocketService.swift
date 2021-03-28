//
//  RocketService.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 28/03/21.
//

import Foundation
import RxSwift

protocol RocketServiceProtocol {
    func fetchLaunches(rocketId : String) -> Observable<Rocket>
}

class RocketService : RocketServiceProtocol {
    func fetchLaunches(rocketId : String) -> Observable<Rocket> {
        return Observable.create { (observer) -> Disposable in
            
            let url = Constants.URLS.baseURL + Constants.URLS.rocketsAPI + rocketId
            
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
                do {
                    let launches = try JSONDecoder().decode(Rocket.self, from: data!)
                    observer.onNext(launches)
                } catch {
                    print("Error: ", error)
                    observer.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
}
