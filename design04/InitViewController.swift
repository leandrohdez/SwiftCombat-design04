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
    
    var navigationItemTitleLabel    = UILabel()
    var navigationItemSubtitleLabel = UILabel()
    
    
    // MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.performNavigationItem()
        self.navigationBarVisibility(false)
        
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(image: UIImage(named: "setting-icon"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("settingAction"))
        self.navigationItem.leftBarButtonItem   = UIBarButtonItem(image: UIImage(named: "back_icon"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("shareAction"))
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        
        let height: CGFloat = CGRectGetHeight(UIScreen.mainScreen().bounds)*0.35
        
        let headerView = ParallaxHeaderView(image: UIImage(named: "photographer")!, frame: CGSizeMake(CGRectGetWidth(UIScreen.mainScreen().bounds), height))
        headerView.usernameLabel!.text = "Bread Chicken"
        headerView.userfromLabel!.text = "From Shanghai"
        
        headerView.didScroll = { (offset: CGFloat) -> Void in
            
            if offset > 70 {
                UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
                self.navigationController?.navigationBar.tintColor = UIColor.darkGrayColor()
            }
            else {
                UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
                self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
            }
            
            if offset > 130 {
                self.navigationBarVisibility(true)
                self.navigationItemTitleLabel.text = "Bread Chicken"
                self.navigationItemSubtitleLabel.text = "From Shanghai"
            }
            else {
                self.navigationBarVisibility(false)
                self.navigationItemTitleLabel.text = ""
                self.navigationItemSubtitleLabel.text = ""
            }
        }
        
        self.tableView!.tableHeaderView = headerView
        
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    func settingAction() {
        
    }
    
    func shareAction() {
        
    }
    
    
    // MARK: - TableView Delegates
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UserMessageTextCell()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    // MARK: -
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.tableView {
            (self.tableView!.tableHeaderView as! ParallaxHeaderView).layoutHeaderViewForScrollViewOffset(scrollView.contentOffset)
        }
    }
    
    // MARK: - Navigation Item
    func performNavigationItem() {
        self.navigationItem.titleView = UIView(frame: CGRectMake(0, 0, 200, 44))
        
        self.navigationItemTitleLabel = UILabel(frame: CGRectMake(0, 2, 200, 24))
        self.navigationItemTitleLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        self.navigationItemTitleLabel.textAlignment = NSTextAlignment.Center
        self.navigationItemTitleLabel.adjustsFontSizeToFitWidth = true
        self.navigationItem.titleView!.addSubview(self.navigationItemTitleLabel)
        
        self.navigationItemSubtitleLabel = UILabel(frame: CGRectMake(0, 24, 200, 20))
        self.navigationItemSubtitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        self.navigationItemSubtitleLabel.textAlignment = NSTextAlignment.Center
        self.navigationItemSubtitleLabel.adjustsFontSizeToFitWidth = true
        self.navigationItem.titleView!.addSubview(self.navigationItemSubtitleLabel)
    }
    
    func navigationBarVisibility(visible: Bool) {
        if visible == true {
            self.navigationController?.navigationBar.tintColor = UIColor.darkGrayColor()
            self.navigationController?.navigationBar.setBackgroundImage(ImageWithColor(UIColor.whiteColor()), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = ImageWithColor(UIColor.darkGrayColor().colorWithAlphaComponent(0.4), size: CGSizeMake(0.5, 0.5))
            self.navigationController?.navigationBar.translucent = false
            
            self.navigationItemTitleLabel.textColor = UIColor.blackColor()
            self.navigationItemSubtitleLabel.textColor = UIColor.darkGrayColor()
        }
        else{
            self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.translucent = true
            
            self.navigationItemTitleLabel.textColor = UIColor.whiteColor()
            self.navigationItemSubtitleLabel.textColor = UIColor.whiteColor()
        }
    }
    
    // MARK: -
    // tambien ahacer asi...
    // para ver los iconos del status bar en blanco
    // el icono verde de la bateria solo se ve verde mientras este conectado el telefono cargando
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    
    
    // MARK: -
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
