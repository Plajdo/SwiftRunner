//
//  AppDelegate.swift
//  NoteToMyself
//
//  Created by Filip Šašala on 28/08/2018.
//  Copyright © 2018 plajdo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		//Set status bar colour to white
		UIApplication.shared.statusBarStyle = .lightContent
		loadApplicationData()
		
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
		
		saveApplicationData()
		
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
		
		loadApplicationData()
		
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	func loadApplicationData(){
		let defaults = UserDefaults.standard
		let headings = defaults.stringArray(forKey: "noteTitles")
		let messages = defaults.stringArray(forKey: "noteContents")
		
		ViewController.loadNotes(titles: headings ?? ["Error loading notes"], contents: messages ?? ["Not found"])
		
	}
	
	func saveApplicationData(){
		let defaults = UserDefaults.standard
		defaults.set(ViewController.notes, forKey: "noteTitles")
		defaults.set(ViewController.notesContent, forKey: "noteContents")
		
	}
	
}
