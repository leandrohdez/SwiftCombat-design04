//
//  TintImage.swift
//  design04
//
//  Created by IT-ELEVEN on 23/9/15.
//  Copyright © 2015 swiftcombat. All rights reserved.
//

import UIKit

class TintImage: UIImageView{

    
    func overlayLayerColor (color: UIColor) {
        let overlayView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        overlayView.backgroundColor = color.colorWithAlphaComponent(0.96)
    
        overlayView.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleWidth, .FlexibleHeight]
        
        self.addSubview(overlayView)
        
        self.image = TintImage.setOverlayColor(self.image!, color: color)
    }
    
    
    class func setOverlayColor(image: UIImage, color: UIColor) -> UIImage {
        //self.color = color
    
        // Begin drawing
        let rect: CGRect = CGRectMake(0, 0, image.size.width, image.size.height)
        UIGraphicsBeginImageContext(rect.size)
        
        // Get the graphic context
        let c: CGContextRef = UIGraphicsGetCurrentContext()!

        // Draw the image
        image.drawInRect(rect)
        
        // Set the fill color space
        let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
        CGContextSetFillColorSpace(c, colorSpace)
        
        // Set the mask to only tint non-transparent pixels
        CGContextClipToMask(c, rect, image.CGImage)
        
        // Set the fill color
        CGContextSetFillColorWithColor(c, color.CGColor)
        
        UIRectFillUsingBlendMode(rect, CGBlendMode.Color)
        
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
    }
}
