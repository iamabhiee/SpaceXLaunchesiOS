//
//  LaunchesServiceRequests.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 26/03/21.
//

import Foundation

typealias RocketsServiceRequestResponse = (Result<Rocket, Error>) -> Void

protocol RocketsServiceRequestsType {
    @discardableResult func getRockets(id : String, completion: @escaping RocketsServiceRequestResponse) -> URLSessionDataTask?
}

struct RocketsServiceRequests: RocketsServiceRequestsType {
    
    @discardableResult func getRockets(id : String, completion: @escaping RocketsServiceRequestResponse) -> URLSessionDataTask? {
        let rocketsRequestModel = APIRequestModel(api: RocketsAPI.getRockets(id: id))
        return WebserviceHelper.requestAPI(apiModel: rocketsRequestModel) { response in
            switch response {
            case .success(let serverData):
                JSONResponseDecoder.decodeFrom(serverData, returningModelType: Rocket.self, completion: { (allRestaurantResponse, error) in
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
