//
//  ViewController.swift
//  NoteToMyself
//
//  Created by Filip Šašala on 28/08/2018.
//  Copyright © 2018 plajdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    let cellIdentifier : String = "NoteCell"
    var notes : [String] = ["Poznámka", "Nákupný zoznam"]
    var notesContent : [String] = ["Toto je text poznámky, ktorý ide do druhého riadka", "Mrkva, jablko, mlieko, cukor"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNote(lockOn: Any, note: String, content: String){
        objc_sync_enter(lockOn)
        defer {
            objc_sync_exit(lockOn)
        }
        
        notes.append(note)
        notesContent.append(content)
        
        table.beginUpdates()
        let indexPath = IndexPath(row: notes.count - 1, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.endUpdates()
        table.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
    }
    
    @IBAction func buttonAdd(_ sender: UIBarButtonItem) {
        insertNote(lockOn: self, note: "henlo", content: "content")
        
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    //getRowCount
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    //getCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = notes[indexPath.row]
        let content = notesContent[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        cell!.textLabel!.text = title
        cell!.detailTextLabel!.text = content
        
        return cell!
        
    }
    
    //isEditable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //cellEdited
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            notes.remove(at: indexPath.row)
            notesContent.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        }
        
    }
    
    //cellSelected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView.cellForRow(at: indexPath)?.textLabel?.text as Any)
    }
    
}
