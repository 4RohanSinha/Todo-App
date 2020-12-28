//
//  MainVC.swift
//  todo-app-core
//
//  Created by Rohan Sinha on 12/26/20.
//

import UIKit


class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var todos: [Todo] = []
    @IBOutlet weak var todosTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTodos()
        print(self.todos)
        todosTable.reloadData()
        
        if self.todos.count < 1 {
            todosTable.isHidden = true
        } else {
            todosTable.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        todosTable.delegate = self
        todosTable.dataSource = self
        
        fetchTodos()
    
        print(self.todos)
        
    }
    
    func fetchTodos() {
        CoreDataManagerService_Todo.shared.fetchTodos { (todos_fetched) in
            self.todos = todos_fetched
            self.todos.sort { (todo1, todo2) -> Bool in
                guard let todo1_due_date = todo1.due_date else { return false }
                guard let todo2_due_date = todo2.due_date else { return false }
                return todo1_due_date < todo2_due_date
            }
            
        } onError: { (error) in
            debugPrint(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as? TodoCell {
            
            let date_formatter_1  = DateFormatter()
            date_formatter_1.dateFormat = "E, d MMM y @ hh:mm a"
            date_formatter_1.amSymbol = "AM"
            date_formatter_1.pmSymbol = "PM"
            
            cell.selectionStyle = .none
            cell.updateView(todo: self.todos[indexPath.row], date_as_string: date_formatter_1.string(from: self.todos[indexPath.row].due_date ?? Date()))
            return cell
        }
        
        return TodoCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            CoreDataManagerService_Todo.shared.deleteTodo(todo: self.todos[indexPath.row]) { (success, msg) in
                debugPrint(msg)
                self.fetchTodos()
                self.todosTable.deleteRows(at: [indexPath], with: .automatic)
                
                if self.todos.count < 1 {
                    self.todosTable.isHidden = true
                } else {
                    self.todosTable.isHidden = false
                }
                
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "EDIT") { (rowAction, indexPath) in
            
        }
        
        let completeAction = UITableViewRowAction(style: .normal, title: "COMPLETE") { (rowAction, indexPath) in
            self.todos[indexPath.row].isCompleted = true
            CoreDataManagerService_Todo.shared.save { (success, msg) in
                debugPrint(msg)
                self.todosTable.reloadData()
            }
        }
        
        
        editAction.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
        
        completeAction.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        return [deleteAction, editAction, completeAction]
    }
    
}

