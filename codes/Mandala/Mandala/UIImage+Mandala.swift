//
//  UIImage+Mandala.swift
//  Mandala
//
//  Created by Changhyun Baek on 2020/05/27.
//  Copyright © 2020 paikwiki. All rights reserved.
//

import UIKit

enum ImageResource: String {
    case angry
    case confused
    case crying
    case goofy
    case happy
    case meh
    case sad
    case sleepy
}

extension UIImage {
    
    convenience init(resource: ImageResource) {
        self.init(named: resource.rawValue)!
    }
    
}
