//
//  AddEffectInImage.swift
//  RSSReader
//
//  Created by Neskin Ivan on 13.12.2020.
//  Copyright © 2020 Neskin Ivan. All rights reserved.
//

import UIKit

class AddEffectInImage {
    
    func convertToGrayScale(image: UIImage) -> UIImage {
        
        let imageRect:CGRect = CGRect(x:0, y:0, width:image.size.width, height: image.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(image.cgImage!, in: imageRect)
        let imageRef = context!.makeImage()
        
        let newImage = UIImage(cgImage: imageRef!)
        
        return newImage
    }
    
    func addBlurEffect(image:UIImage) -> UIImage? {
        let inputCIImage = CIImage(image: image)!
        
        // Create Blur CIFilter, and set the input image
        let blurFilter = CIFilter(name: "CIGaussianBlur")!
        blurFilter.setValue(inputCIImage, forKey: kCIInputImageKey)
        blurFilter.setValue(8, forKey: kCIInputRadiusKey)

        // Get the filtered output image and return it
        let outputImage = blurFilter.outputImage!
        return UIImage(ciImage: outputImage)
    }

}
