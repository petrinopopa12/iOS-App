//
//  TaskItem.swift
//  iOS-App
//
//

import SwiftUI
import RealmSwift

class TaskItem: Object,Identifiable{
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var taskTitle: String
    @Persisted var taskDate: Date = Date()
    
    @Persisted var taskStatus: TaskStatus = .pending
    
}

enum TaskStatus: String,PersistableEnum{
    case missed = "Missed"
    case completed = "Completed"
    case pending = "Pending"
}

