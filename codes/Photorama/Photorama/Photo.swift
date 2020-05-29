//
//  Photo.swift
//  Photorama
//
//  Created by Changhyun Baek on 2020/05/29.
//  Copyright © 2020 paikwiki. All rights reserved.
//

import Foundation

class Photo: Codable {
    let title: String
    let remoteURL: URL?
    let photoID: String
    let dateTaken: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_z"
        case photoID = "id"
        case dateTaken = "datetaken"
    }
}
