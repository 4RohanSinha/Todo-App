//
//  TodoCell.swift
//  todo-app-core
//
//  Created by Rohan Sinha on 12/26/20.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var task_label: UILabel!
    @IBOutlet weak var priority_label: UILabel!
    @IBOutlet weak var due_date_label: UILabel!
    @IBOutlet weak var taskCompletedLabel: UILabel!
    
    func updateView(todo: Todo, date_as_string: String) {
        task_label.text = todo.task
        priority_label.text = todo.priority
        due_date_label.text = date_as_string
        
        guard let todo_date = todo.due_date else {
            return
        }
        
        if todo.isCompleted {
            taskCompletedLabel.isHidden = false
        } else {
            taskCompletedLabel.isHidden = true
            if Date() > todo_date {
                backgroundColor = #colorLiteral(red: 1, green: 0.7364771879, blue: 0.6923906585, alpha: 1)
            }
        }
    }
}
