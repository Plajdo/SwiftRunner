//
//  ViewController.swift
//  WebSocket Chat
//
//  Created by Filip Šašala on 01/07/2018.
//  Copyright © 2018 plajdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var textField: UITextField!
    var messages : [String] = ["plz"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertNewMessage()
        table.tableFooterView = UIView(frame: CGRect.zero)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonOnClick(_ sender: UIButton) {
        insertNewMessage()
    }
    
    func insertNewMessage() {
        print(textField.text!)
        messages.append(textField.text!)
        
        table.beginUpdates()
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.endUpdates()
        table.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        cell.messageContents.text = message
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == .delete){
            messages.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        
    }
    
}
