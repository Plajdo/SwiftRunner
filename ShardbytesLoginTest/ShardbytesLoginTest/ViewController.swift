//
//  ViewController.swift
//  ShardbytesLoginTest
//
//  Created by Filip Šašala on 26/07/2018.
//  Copyright © 2018 plajdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var statusLabel: UILabel!
	@IBOutlet weak var saltTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func onVerifyClick(_ sender: UIButton) {
		getSalt(afterDataRecieved: {(data) -> () in
			self.saltTextField.text = data
		})
		
	}
	
	func getSalt(afterDataRecieved: @escaping (_ data: String) -> ()){
		let saltAddress : String = "https://shardbytes.com/user/sebu/salt"
		let saltURL = URL(string: saltAddress)
		let request = URLRequest(url: saltURL!)
		let config = URLSessionConfiguration.default
		let session = URLSession(configuration: config)
		let task = session.dataTask(with: request){(data, response, error) in
			guard error == nil else {
				print("error happened")
				return
			}
			
			guard let responseData = data else {
				print("no data")
				return
			}
			
			afterDataRecieved(responseData.toString())
			
		}
		task.resume()
		
	}
	
}


