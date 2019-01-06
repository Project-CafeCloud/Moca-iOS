//
//  CafeDetailReviewService.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 6..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CafeDetailReviewService: APIService, RequestService {
    static let shareInstance = CafeDetailReviewService()
    let URL = url("/review")
    typealias NetworkData = CafeDetailReviewData
    
    func getCafeDetailReview(cafeId: Int, token: String, completion: @escaping ([CafeDetailReview]) -> Void, error: @escaping (Int) -> Void) {
        let reviewURL = URL + "/\(cafeId)/best"
        let header: HTTPHeaders = [
            "Authoirzation" : token ,
            "Content-Type" : "application/json"
        ]
        gettable(reviewURL, body: nil, header: header) { res in
            switch res {
            case .success(let CafeDetailReviewData):
                let data = CafeDetailReviewData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}