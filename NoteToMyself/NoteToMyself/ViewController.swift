//
//  ViewController.swift
//  NoteToMyself
//
//  Created by Filip Šašala on 28/08/2018.
//  Copyright © 2018 plajdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    let cellIdentifier : String = "noteCell"
    var notes : [String] = ["hey", "oh", "ayyy"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(NoteTableCell.self, forCellReuseIdentifier: cellIdentifier)
        table.delegate = self
        table.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNote(lockOn : Any, note : String){
        objc_sync_enter(lockOn)
        defer {
            objc_sync_exit(lockOn)
        }
        
        print(note)
        notes.append(note)
        
        table.beginUpdates()
        let indexPath = IndexPath(row: notes.count - 1, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.endUpdates()
        table.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    //getRowCount
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    //getCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title : String = notes[indexPath.row]
        let cell : NoteTableCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! NoteTableCell
        
        cell.title?.text = title
        cell.content?.text = "content"
        
        return cell
        
    }
    
    //isEditable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //cellEdited
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            notes.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        }
        
    }
    
    //cellSelected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print((tableView.cellForRow(at: indexPath) as! NoteTableCell).title.text!)
    }
    
}
