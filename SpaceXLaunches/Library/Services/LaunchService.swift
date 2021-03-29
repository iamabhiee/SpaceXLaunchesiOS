//
//  LaunchesService.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 28/03/21.
//

import RxSwift

protocol LaunchServiceProtocol {
    func fetchLaunches() -> Observable<[Launch]>
}

class LaunchService : LaunchServiceProtocol {
    func fetchLaunches() -> Observable<[Launch]> {
        return Observable.create { (observer) -> Disposable in
            
            let url = Constants.URLS.baseURL + Constants.URLS.launchesAPI
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
                do {
                    let launches = try JSONDecoder().decode([Launch].self, from: data!)
                    let filtetedLaunches = self.applyFilter(launchList: launches)
                    observer.onNext(filtetedLaunches)
                } catch {
                    print("Error: ", error)
                    observer.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
    func applyFilter(launchList : [Launch]) -> [Launch] {
        let allLaunches = launchList
        let filtedLaunchhes = allLaunches.filter({ (launch) -> Bool in
            
            // Filter only last 3 years data
            let currentYear = Calendar.current.component(.year, from: Date())
            let lastThreeYears = [currentYear, currentYear-1, currentYear-2]
            
            if let launchDate = Date.dateFromUTCServerDate(date: launch.date_utc), lastThreeYears.contains(Calendar.current.component(.year, from: launchDate)) {
                
                let successfulLaunch = (launch.success == true)
                let upcomingLaunch = launchDate > Date()
                
                if successfulLaunch || upcomingLaunch  {
                    return true
                } else {
                    return false
                }
            }
            
            return false
        })
        return filtedLaunchhes
    }
}
