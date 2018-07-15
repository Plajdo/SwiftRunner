//
//  ViewController.swift
//  WebSocket Chat
//
//  Created by Filip Šašala on 01/07/2018.
//  Copyright © 2018 plajdo. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet var table: UITableView!
	@IBOutlet var textField: UITextField!
	
	var messages : [String] = []
	var clientInsert : Bool = true	//true - when table loads, it needs to know how to insert all the data in messages array and value cannot be nil
	let cellIdentifier : String = "MessageCell"
	
	//Socket object
	let socket = WebSocket(url: URL(string: "wss://shardbytes.herokuapp.com/echo")!)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//Set socket stuff and connect
		socket.onText = { (text: String) in
			self.insertMessage(lockOn: self, server: true, message: text)
		}
		socket.connect()
		
		//Register something with table?
		table.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
		
		//Delegate and data source
		table.delegate = self
		table.dataSource = self
		
		table.tableFooterView = UIView(frame: CGRect.zero)
		
		//Auto row size
		table.estimatedRowHeight = 44.0
		table.rowHeight = UITableViewAutomaticDimension
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func buttonOnClick(_ sender: UIButton) {
		insertMessage(lockOn: self, server: false, message: textField.text!)
		if(socket.isConnected){
			socket.write(string: textField.text!)
		}else{
			print("not connected to websocket server!")
		}
		textField.text = ""
	}
	
	//Synchronized function
	func insertMessage(lockOn: Any, server: Bool, message: String) {
		objc_sync_enter(lockOn)
		defer {
			objc_sync_exit(lockOn)
		}
		
		print(message)
		messages.append(message)
		
		clientInsert = !server
		
		table.beginUpdates()
		let indexPath = IndexPath(row: messages.count - 1, section: 0)
		table.insertRows(at: [indexPath], with: .automatic)
		table.endUpdates()
		table.scrollToRow(at: indexPath, at: .bottom, animated: true)
		
		clientInsert = true
		
	}
	
}

/*
* ViewController extension
* Code that happens when something happens (?)
*/
extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	//getRowCount
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messages.count
	}
	
	//getCell(cellIndex)
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let message = messages[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
		cell!.textLabel!.text = message
		
		if(clientInsert){
			cell!.backgroundColor = UIColor.blue	//Client is blue colour
			cell!.textLabel!.textColor = UIColor.white
			cell!.textLabel!.textAlignment = NSTextAlignment.right
		}else{
			cell!.backgroundColor = UIColor.green	//Server reply is green colour
			cell!.textLabel!.textColor = UIColor.white
			cell!.textLabel!.textAlignment = NSTextAlignment.left
		}
		
		return cell!
		
	}
	
	//isEditable(cellIndex)
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	//cellEdited(editingStyle, cellIndex)
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if(editingStyle == .delete){
			messages.remove(at: indexPath.row)
			tableView.beginUpdates()
			tableView.deleteRows(at: [indexPath], with: .automatic)
			tableView.endUpdates()
		}
		
	}
	
	//cellSelected(cellIndex)
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(tableView.cellForRow(at: indexPath)!.textLabel!.text!)
	}
	
}

