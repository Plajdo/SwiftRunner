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
    
    var messages : [String] = ["hehe"]
    var clientInsert : Bool = true
    
    let cellIdentifier : String = "MessageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView(frame: CGRect.zero)
        table.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonOnClick(_ sender: UIButton) {
        insertNewMessage(fromServer: false)
        textField.text = ""
    }
    
    func insertNewMessage(fromServer: Bool) {
        print(textField.text!)
        messages.append(textField.text!)
        
        table.beginUpdates()
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.endUpdates()
        table.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
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
            cell!.backgroundColor = UIColor.blue
            cell!.textLabel!.textColor = UIColor.white
        }else{
            cell!.backgroundColor = UIColor.green
            cell!.backgroundColor = UIColor.white
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
        
    }
    
}
