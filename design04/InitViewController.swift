//
//  InitViewController.swift
//  design04
//
//  Created by IT-ELEVEN on 22/9/15.
//  Copyright © 2015 swiftcombat. All rights reserved.
//

import UIKit

class InitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView?
    
    var data = []
    
    
    // MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBarVisibility(false)
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        
        let height: CGFloat = CGRectGetHeight(UIScreen.mainScreen().bounds)*0.35
        
        let headerView = ParallaxHeaderView(image: UIImage(named: "193503__nature-twigs-branches-leaves-autumn-snow_p")!, frame: CGSizeMake(CGRectGetWidth(UIScreen.mainScreen().bounds), height))
        headerView.titleLabel.text = "Hola mundo"
        
        self.tableView!.tableHeaderView = headerView
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    // MARK: - TableView Delegates
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = "asd"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: -
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.tableView {
            (self.tableView!.tableHeaderView as! ParallaxHeaderView).layoutHeaderViewForScrollViewOffset(scrollView.contentOffset)
        }
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
