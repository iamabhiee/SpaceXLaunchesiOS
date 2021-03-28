//
//  LaunchesAPI.swift
//  SpaceXLaunches
//
//  Created by Abhishek on 26/03/21.
//

import Foundation

///  This API will hold all APIs related to Launches
enum LaunchesAPI {
    case getLaunches
}

extension LaunchesAPI: APIProtocol {
    func httpMthodType() -> HTTPMethodType {
        var methodType = HTTPMethodType.get
        switch self {
        
        case .getLaunches:
            methodType = .get
        }
        return methodType
    }

    func apiEndPath() -> String {
        var apiEndPath = ""
        switch self {
        case .getLaunches:
            apiEndPath += WebserviceConstants.apiVersion4 + WebserviceConstants.launchesAPI
        }
        return apiEndPath
    }

    func apiBasePath() -> String {
        switch self {
        case .getLaunches:
            return WebserviceConstants.baseURL
        }
    }
}
