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
    
    var backgroundImage = UIImage()
    
    var imageScrollView: UIScrollView?
    var userImageView: UIImageView?
    var bluredImageView: UIImageView?
    
    var usernameLabel: UILabel?
    var userfromLabel: UILabel?
    
    var didScroll: ((offset: CGFloat)->())?
    
    
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
            
            self.bluredImageView!.alpha =   1 / CGRectGetHeight(self.frame) * offset.y * 2
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
            self.bluredImageView!.alpha =   1 / CGRectGetHeight(self.frame) * offset.y * 2
        }
        
        self.didScroll!(offset: offset.y)
    }
    
    
    // MARK: -
    func performHeaderViewData() {
        let scrollView = UIScrollView(frame: self.bounds)
        self.imageScrollView = scrollView
        
        // background image
        let imageView = TintImage(frame: scrollView.bounds)
        imageView.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleWidth, .FlexibleHeight]
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.image = self.backgroundImage
        imageView.overlayLayerColor(UIColorFromRGB(0x1a84be))
        self.imageScrollView!.addSubview(imageView)
        
        // user picture rect
        var imageUserRect = self.imageScrollView!.bounds
        imageUserRect.origin.x = 0
        imageUserRect.origin.y = 10
        imageUserRect.size.width = 88
        imageUserRect.size.height = 88
        
        // user picture
        self.userImageView = UIImageView(image: UIImage(named: "photographer"))
        self.userImageView!.frame = imageUserRect
        self.userImageView!.center = CGPointMake(CGRectGetWidth(UIScreen.mainScreen().bounds)/2, self.userImageView!.center.y)
        self.userImageView!.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleWidth]
        // circular
        self.userImageView!.layer.cornerRadius = CGRectGetHeight(self.userImageView!.frame)/2
        self.userImageView!.clipsToBounds = true
        // border
        self.userImageView!.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.8).CGColor
        self.userImageView!.layer.borderWidth = 2
        self.imageScrollView!.addSubview(self.userImageView!)
        
        // user name rect
        var labelNameRect = self.imageScrollView!.bounds
        labelNameRect.origin.x = kLabelPaddingDist
        labelNameRect.origin.y = 115
        labelNameRect.size.width = labelNameRect.size.width - 2 * kLabelPaddingDist
        labelNameRect.size.height = 30
        
        // user name label
        self.usernameLabel = UILabel(frame: labelNameRect)
        self.usernameLabel!.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleWidth]
        self.usernameLabel!.textColor = UIColor.whiteColor()
        self.usernameLabel!.textAlignment = NSTextAlignment.Center
        self.usernameLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 23)
        self.imageScrollView!.addSubview(self.usernameLabel!)
        
        // user from rect
        var labelFromRect = self.imageScrollView!.bounds
        labelFromRect.origin.x = kLabelPaddingDist
        labelFromRect.origin.y = 145
        labelFromRect.size.width = labelFromRect.size.width - 2 * kLabelPaddingDist
        labelFromRect.size.height = 20
        
        // user from label
        self.userfromLabel = UILabel(frame: labelFromRect)
        self.userfromLabel!.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleWidth]
        self.userfromLabel!.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        self.userfromLabel!.textAlignment = NSTextAlignment.Center
        self.userfromLabel!.font = UIFont(name: "HelveticaNeue", size: 15)
        self.imageScrollView!.addSubview(self.userfromLabel!)
        
        self.bluredImageView = UIImageView(frame: imageView.frame)
        self.bluredImageView!.autoresizingMask = imageView.autoresizingMask
        self.bluredImageView!.alpha = 0
        self.bluredImageView!.image = ImageWithColor(UIColor.whiteColor())
        self.imageScrollView!.addSubview(self.bluredImageView!)
        
        self.addSubview(self.imageScrollView!)
    }
    
    
    
    
}
