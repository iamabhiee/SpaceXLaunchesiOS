//
//  RocketsAPI.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 26/03/21.
//

import Foundation

///  This API will hold all APIs related to Rockets
enum RocketsAPI {
    case getRockets(id : String)
}

extension RocketsAPI: APIProtocol {
    func httpMthodType() -> HTTPMethodType {
        var methodType = HTTPMethodType.get
        switch self {
        
        case .getRockets(_):
            methodType = .get
            
        
        }
        return methodType
    }

    func apiEndPath() -> String {
        var apiEndPath = ""
        switch self {
        
        case .getRockets(let rocketId):
        apiEndPath += WebserviceConstants.apiVersion4 + WebserviceConstants.rocketsAPI + rocketId
        }
        return apiEndPath
    }

    func apiBasePath() -> String {
        switch self {
        
        case .getRockets(_):
            return WebserviceConstants.baseURL
        }
    }
}
