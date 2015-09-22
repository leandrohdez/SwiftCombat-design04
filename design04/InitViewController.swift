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
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
    
        let headerView = ParallaxHeaderView.parallaxHeaderViewWithImage(UIImage(named: "Jiker")!, headerSize: CGSizeMake(CGRectGetWidth(self.tableView!.frame), 300))
        (headerView as! ParallaxHeaderView).titleLabel.text = "Hola mundo"
        
        self.tableView!.tableHeaderView = headerView
    }

    override func viewDidAppear(animated: Bool) {
        let headerView = ParallaxHeaderView.parallaxHeaderViewWithImage(UIImage(named: "Jiker")!, headerSize: CGSizeMake(CGRectGetWidth(self.tableView!.frame), 300))
        (headerView as! ParallaxHeaderView).titleLabel.text = "Hola mundo"
        
        self.tableView!.tableHeaderView = headerView
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
    
    
    // MARK: -
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.tableView {
            (self.tableView!.tableHeaderView as! ParallaxHeaderView).layoutHeaderViewForScrollViewOffset(scrollView.contentOffset)
        }
    }
    
    
    // MARK: -
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
