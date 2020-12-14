//
//  Utills.swift
//  RSSReader
//
//  Created by Neskin Ivan on 12.12.2020.
//  Copyright © 2020 Neskin Ivan. All rights reserved.
//

import UIKit

extension UIButton {
    class func setupButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 5
//        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}

extension UIImage {
    var noir: UIImage? {
    let context = CIContext(options: nil)
    if let filter = CIFilter(name: "CIPhotoEffectNoir") {
        filter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = filter.outputImage {
            if let cgImage = context.createCGImage(output, from: output.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
    }
    return nil
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
