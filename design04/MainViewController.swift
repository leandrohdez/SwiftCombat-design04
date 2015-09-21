//
//  MainViewController.swift
//  design04
//
//  Created by IT-ELEVEN on 17/9/15.
//  Copyright (c) 2015 swiftcombat. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    // constantes 
    let constHeaderHeight: CGFloat = 250
    let constNavBarHeight: CGFloat = 64
    
    @IBOutlet var headerView: UIView?
    @IBOutlet var headerImage: UIImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarVisibility(false)
        
        // Ademas:
        // activar la propiedad del TableViewController (Under Top Bars) en el StoryBoard
        // desactivar la propiedad del TableViewController (Layout, Adjunt Scroll View Controller) en el StoryBoard
        self.view.sendSubviewToBack(self.headerView!)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.headerView!.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), self.constHeaderHeight)
        
        self.headerImage?.image = imageWithImage(UIImage(named: "wood")!, newSize: CGSizeMake(/*CGRectGetWidth(self.headerView!.frame)*/320, /*self.constHeaderHeight*/250))
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseCellIdentifier", forIndexPath: indexPath) 
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    // MARK: -
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollOffsetY = self.constHeaderHeight - scrollView.contentOffset.y
        
        // stretch the header view if neccessary
        if scrollOffsetY > self.constHeaderHeight {
            // stretch
            //self.headerImage!.contentMode = UIViewContentMode.Center
            self.headerTopLayoutConstraint()?.constant = self.constHeaderHeight - scrollOffsetY
        }
        else {
            // scroll
            //self.headerImage!.contentMode = UIViewContentMode.Center
            self.headerTopLayoutConstraint()?.constant = -(self.constHeaderHeight - scrollOffsetY)
            self.headerBootomLayoutConstraint()?.constant = -2*(self.constHeaderHeight - scrollOffsetY)
        }
        
        // show or hide the navigation bar
        if scrollOffsetY <= self.constNavBarHeight {
            self.navigationBarVisibility(true)
        }
        else{
            self.navigationBarVisibility(false)
        }
    }
    
    
    // MARK: -
    func headerTopLayoutConstraint() -> NSLayoutConstraint? {
        for layout in self.headerView!.constraints {
            if layout.firstAttribute == NSLayoutAttribute.Top {
                return layout
            }
        }
        return nil
    }
    
    func headerBootomLayoutConstraint() -> NSLayoutConstraint? {
        for layout in self.headerView!.constraints {
            if layout.firstAttribute == NSLayoutAttribute.Bottom {
                return layout
            }
        }
        return nil
    }
    
    
    // MARK: -
    func navigationBarVisibility(visible: Bool) {
        if visible == true {
            self.navigationController?.navigationBar.setBackgroundImage(ImageWithColor(UIColor.whiteColor()), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = ImageWithColor(UIColor.darkGrayColor().colorWithAlphaComponent(0.4), size: CGSizeMake(0.5, 0.5))
            self.navigationController?.navigationBar.translucent = true
        }
        else{
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.translucent = true
        }
    }
    
    // MARK: -
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
