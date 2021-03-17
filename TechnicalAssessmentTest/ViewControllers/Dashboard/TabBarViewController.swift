//
//  TabBarViewController.swift
//  spiiomobile
//
//  Created by Mihir Thakkar on 23/10/20.
//  Copyright © 2020 Mihir Thakkar. All rights reserved.
//

import UIKit
import AZTabBar
class TabBarViewController: UIViewController, AZTabBarDelegate {

    var AZTabBarC:AZTabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAZTabbar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setAZTabbar()
    {
        var icons = [UIImage]()
        icons.append(Constants.images.posts!)
        icons.append(Constants.images.favourites!)
    
        AZTabBarC = .insert(into: self, withTabIcons: icons)

        AZTabBarC.delegate = self

        let v2 = appDelegate.myStoryboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        //let v3 = appDelegate.myStoryboard.instantiateViewController(withIdentifier: "InstallWebViewController") as! InstallWebViewController
        
        let v3 = appDelegate.myStoryboard.instantiateViewController(withIdentifier: "FavouritesViewController") as! FavouritesViewController
        
        let vc2 = UINavigationController(rootViewController: v2)
        let vc3 = UINavigationController(rootViewController: v3)
    
        AZTabBarC.setViewController(vc2, atIndex: 0)
        AZTabBarC.setViewController(vc3, atIndex: 1)
        
        AZTabBarC.setTitle("Posts".uppercased(), atIndex: 0)
        AZTabBarC.setTitle("Favourites".uppercased(), atIndex: 1)
        
        AZTabBarC.font = UIFont.systemFont(ofSize: Utilities.dynamicFontSizeForIphone(fontSize: 9.0))
        
        //default color of the icons on the buttons
        AZTabBarC.defaultColor = Constants.color.colorGreenLight

        //the color of the icon when a menu is selected
        AZTabBarC.selectedColor = Constants.color.colorGreenDark

        //The color of the icon of a highlighted tab
        AZTabBarC.highlightColor = Constants.color.colorGreenDark

        //The background color of the tab bar
        AZTabBarC.buttonsBackgroundColor = Constants.color.colorToolbar
        
        //Tabbar height
        AZTabBarC.tabBarHeight = Utilities.getHeight(height: 40)
        
        // default is 3.0
        AZTabBarC.selectionIndicatorHeight = 0

        //hide or show the seperator line
        AZTabBarC.separatorLineVisible = false
    
        AZTabBarC.animateTabChange = false
        
        
    }
    
}
