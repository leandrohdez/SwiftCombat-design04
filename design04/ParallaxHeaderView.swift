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
    
    
    // MARK: - Initialization
    init(image: UIImage, frame: CGSize) {
        self.backgroundImage = image
        super.init(frame: CGRectMake(0, 0, frame.width, frame.height))
        // do "performs"
        performHeaderViewData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            let margin: CGFloat = 8
            var delta: CGFloat = 0
            var rect: CGRect = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds)+margin, CGRectGetHeight(self.frame))
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
        
        let imageView = TintImage(frame: scrollView.bounds)
        imageView.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleWidth, .FlexibleHeight]
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.image = self.backgroundImage
        imageView.overlayLayerColor(UIColorFromRGB(0x1a84be))
        self.imageScrollView!.addSubview(imageView)
        
        var userPhoto = UIImageView()
        
        self.addSubview(self.imageScrollView!)
    }
    

    
}
