//
//  AddMessageController.swift
//  NoteToMyself
//
//  Created by Filip Šašala on 29/08/2018.
//  Copyright © 2018 plajdo. All rights reserved.
//

import UIKit

class AddMessageController : UIViewController{
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		
	}
	
	@objc func keyboardWasShown(notification: NSNotification){
		
		if let userInfo = notification.userInfo{
			let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]
			print(keyboardFrame ?? "nil")
		}
		
	}
	
}
