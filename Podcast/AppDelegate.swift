//
//  AppDelegate.swift
//  Podcast
//
//  Created by Mark Bryan on 9/7/16.
//  Copyright © 2016 Cornell App Development. All rights reserved.
//

import UIKit
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController!
    
    var loginVC: LoginViewController!
    var tabBarController: UITabBarController!
    var playerVCnav: UINavigationController!
    var discoverVCnav: UINavigationController!
    var profileVCNav: UINavigationController!
    var searchVCNav: UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Login VC initialization 
        loginVC = LoginViewController()
        
        // Nav + primary app VC initialization
        playerVCnav = UINavigationController()
        playerVCnav.navigationBar.backgroundColor = UIColor.white
        playerVCnav.setNavigationBarHidden(true, animated: true)
        discoverVCnav = UINavigationController()
        discoverVCnav.setNavigationBarHidden(true, animated: true)
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.action = #selector(backButtonPress)
        discoverVCnav.navigationItem.leftBarButtonItem = backButton
        discoverVCnav.setNavigationBarHidden(true, animated: true)
        playerVCnav.pushViewController(PlayerViewController(), animated: false)
        discoverVCnav.pushViewController(DiscoverViewController(), animated: false)
        profileVCNav = UINavigationController()
        profileVCNav.setNavigationBarHidden(true, animated: true)
        profileVCNav.pushViewController(ProfileViewController(), animated: false)
        searchVCNav = UINavigationController()
        searchVCNav.setNavigationBarHidden(true, animated: false)
        searchVCNav.pushViewController(SearchViewController(), animated: false)
        
        // Tabbar initialization
        tabBarController = UITabBarController()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.viewControllers = [discoverVCnav, playerVCnav, searchVCNav, profileVCNav]
        playerVCnav.tabBarItem = UITabBarItem(title: "Player", image: UIImage(), tag: 0)
        discoverVCnav.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(), tag: 1)
        searchVCNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(), tag: 2)
        profileVCNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(), tag: 3)
        
    
        // Facebook Login configuration
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Main NavigationController initialization
        var firstVC : UIViewController?
        
        // Set view / FB user possibly
        if let accessToken = AccessToken.current {
            firstVC = tabBarController
            LoginViewController.setFBUser(authToken: accessToken.authenticationToken)
        } else {
            firstVC = loginVC
        }
        
        // Main window setup
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.makeKeyAndVisible()
        window?.rootViewController = firstVC
        
        
        return true
    }
    
    // OAuth for Facebook
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        debugPrint("Facebook User Logged In")
        window?.rootViewController = tabBarController
        return handled
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func backButtonPress() {
        navigationController.popViewController(animated: false)
    }

}

