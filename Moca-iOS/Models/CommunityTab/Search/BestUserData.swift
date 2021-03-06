//
//  BestUserData.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 10..
//  Copyright © 2019년 박세은. All rights reserved.
//

import Foundation

struct BestUserData: Codable {
    let status: Int
    let message: String
    let data: [BestUser]
}

struct BestUser: Codable {
    let userID, userName: String
    let userPhone: String?
    let userImgURL: String
    let userStatusComment: String?
    let pushFlag, auth, follow: Bool
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case userPhone = "user_phone"
        case userImgURL = "user_img_url"
        case userStatusComment = "user_status_comment"
        case pushFlag = "push_flag"
        case auth, follow
    }
}
