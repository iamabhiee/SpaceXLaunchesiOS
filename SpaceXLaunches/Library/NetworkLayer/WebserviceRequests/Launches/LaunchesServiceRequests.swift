//
//  LaunchesServiceRequests.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 26/03/21.
//

import Foundation

typealias GetLaunchesResponse = (Result<[Launch], Error>) -> Void

protocol LaunchesServiceRequestType {
    @discardableResult func getAllLaunches(completion: @escaping GetLaunchesResponse) -> URLSessionDataTask?
}

struct LaunchesServiceRequests: LaunchesServiceRequestType {
    
    @discardableResult func getAllLaunches(completion: @escaping GetLaunchesResponse) -> URLSessionDataTask? {
        let launchesRequestModel = APIRequestModel(api: LaunchesAPI.getLaunches)
        return WebserviceHelper.requestAPI(apiModel: launchesRequestModel) { response in
            switch response {
            case .success(let serverData):
                JSONResponseDecoder.decodeFrom(serverData, returningModelType: [Launch].self, completion: { (allRestaurantResponse, error) in
                    if let parserError = error {
                        completion(.failure(parserError))
                        return
                    }
                    
                    if let restaurantResponse = allRestaurantResponse {
                        completion(.success(restaurantResponse))
                        return
                    }
                })
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
