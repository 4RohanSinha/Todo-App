//
//  AddTodoVC.swift
//  todo-app-core
//
//  Created by Rohan Sinha on 12/26/20.
//

import UIKit


class AddTodoVC: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    
    @IBOutlet weak var duedate_picker: UIDatePicker!
    
    @IBOutlet weak var finish_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        finish_btn.bindToKeyboard()
    }

    @IBAction func on_finish_press(_ sender: Any) {
        
        guard let taskText = taskTextField.text else { return }
        
        guard let priority = prioritySegment.titleForSegment(at: prioritySegment.selectedSegmentIndex) else { return }
        
        var due_date = duedate_picker.date
        
        CoreDataManagerService_Todo.shared.addTodo(task: taskText, priority: priority, due_date: due_date, isCompleted: false) { (success, msg) in
            debugPrint(msg)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func on_back_btn_press(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
