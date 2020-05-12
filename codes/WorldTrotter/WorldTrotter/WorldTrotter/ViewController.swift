//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Changhyun Baek on 2020/05/12.
//  Copyright © 2020 paikwiki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        let gradient = CAGradientLayer()
        
        gradient.frame = view.bounds
        gradient.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor, UIColor.green.cgColor, UIColor.yellow.cgColor, UIColor.red.cgColor, UIColor.red.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }

}

