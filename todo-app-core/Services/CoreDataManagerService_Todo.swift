//
//  CoreDataManagerService_Todo.swift
//  todo-app-core
//
//  Created by Rohan Sinha on 12/26/20.
//

import Foundation
import CoreData

class CoreDataManagerService_Todo {
    static let shared = CoreDataManagerService_Todo()
    
    func fetchTodos(onSuccess: @escaping ([Todo]) -> Void, onError: @escaping (String) -> Void) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Todo>(entityName: "Todo")
        
        do {
            let todos = try managedContext.fetch(fetchRequest)
            onSuccess(todos)
        } catch {
            onError("Unable to fetch todos")
        }
    }
    
    func addTodo(task: String, priority: String, due_date: Date, isCompleted: Bool, completion: @escaping (_ success: Bool, _ msg: String) -> Void) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let new_todo = Todo(context: managedContext)
        
        new_todo.task = task
        new_todo.priority = priority
        new_todo.due_date = due_date
        new_todo.isCompleted = isCompleted
        
        do {
            try managedContext.save()
            completion(true, "Success: saved todo \(task).")
        } catch {
            completion(false, "Unable to save todo \(task).")
        }
        
    }
    
    func save(completion: @escaping (_ success: Bool, _ msg: String) -> Void) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        do {
            try managedContext.save()
            completion(true, "Succeeded in saving Core Data managed context")
        } catch {
            completion(false, "Unable to save Core Data managed context")
        }
    }
    
    func deleteTodo(todo: Todo, completion: @escaping (_ completion: Bool, _ msg: String) -> Void) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let task = todo.task
        
        managedContext.delete(todo)
        
        do {
            try managedContext.save()
            completion(true, "Success: deleted todo '\(task ?? "")'")
        } catch {
            completion(false, "Unable to delete todo '\(task ?? "")'.")
        }
        
    }
    
}
