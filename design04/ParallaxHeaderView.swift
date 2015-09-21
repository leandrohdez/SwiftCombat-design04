//
//  ParallaxHeaderView.swift
//  design04
//
//  Created by IT-ELEVEN on 21/9/15.
//  Copyright © 2015 swiftcombat. All rights reserved.
//

import UIKit

var kParallaxDeltaFactor: CGFloat   = 0.5
var kMaxTitleAlphaOffset: CGFloat   = 100
var kLabelPaddingDist: CGFloat      = 8



class ParallaxHeaderView: UIView {
    
    var titleLabel = UILabel()
    var backgroundImage = UIImage()
    
    var imageScrollView: UIScrollView?
    var imageView: UIImageView?
    var subview: UIView?
    var bluredImageView: UIImageView?
    
    
    class func parallaxHeaderViewWithImage(image: UIImage, headerSize: CGSize) -> UIView {
        let headerView = ParallaxHeaderView(frame: CGRectMake(0, 0, headerSize.width, headerSize.height))
        headerView.backgroundImage = image
        headerView.performHeaderViewData()
        return headerView
    }
    
    class func parallaxHeaderViewWithSubview(subview: UIView) -> UIView {
        let headerView = ParallaxHeaderView(frame: CGRectMake(0, 0, subview.frame.size.width, subview.frame.size.height))
        headerView.performHeaderCustomView(subview)
        return headerView
    }
    
    
    // MARK: -
    func layoutHeaderViewForScrollViewOffset(offset: CGPoint) {
        var frame: CGRect = self.imageScrollView!.frame
        
        if offset.y > 0 {
            frame.origin.y = max(offset.y*kParallaxDeltaFactor, 0)
            self.imageScrollView!.frame = frame
            self.clipsToBounds = true
        }
        else{
            var delta: CGFloat = 0
            var rect: CGRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
            delta = fabs(min(0, offset.y))
            rect.origin.y -= delta
            rect.size.height += delta
            self.imageScrollView!.frame = rect
            self.clipsToBounds = false
            self.titleLabel.alpha = 1 - delta / kMaxTitleAlphaOffset
        }
    }
    
    
    // MARK: -
    func performHeaderViewData() {
        let scrollView = UIScrollView(frame: self.bounds)
        self.imageScrollView = scrollView
        
        let imageView = UIImageView(frame: scrollView.bounds)
        imageView.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleWidth, .FlexibleHeight]
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.image = self.backgroundImage
        self.imageScrollView!.addSubview(imageView)
        
        self.addSubview(self.imageScrollView!)
    }
    
    func performHeaderCustomView(subview: UIView) {
        let scrollView = UIScrollView(frame: self.bounds)
        self.imageScrollView = scrollView
        self.subview = subview
        subview.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleWidth, .FlexibleHeight]
        self.imageScrollView!.addSubview(subview)
        
        self.addSubview(self.imageScrollView!)
    }
    
    func screenShotOfView (view: UIView) -> UIImage {
        let rectSize: CGRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
        
        UIGraphicsBeginImageContextWithOptions(rectSize.size, true, 0)
        self.drawViewHierarchyInRect(rectSize, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
