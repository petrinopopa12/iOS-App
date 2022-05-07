//
//  Home.swift
//  iOS-App
//
//

import SwiftUI
import RealmSwift

struct Home: View {
    @ObservedResults(TaskItem.self, sortDescriptor: SortDescriptor.init(keyPath: "taskDate", ascending: false)) var tasksFetched
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                if tasksFetched.isEmpty{
                    
                    Text("Add some new tasks")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                else{
                    List{
                        
                        ForEach(tasksFetched){task in
                            TaskRow(task: task)
                            
                                .swipeActions(edge: .trailing, allowsFullSwipe: true){
                                    
                                    Button(role: .destructive) {
                                        $tasksFetched.remove(task)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .animation(.easeInOut, value: tasksFetched)
                }
            }
            .navigationTitle("Tasks")
            .toolbar{
                
                Button{
                    let task = TaskItem()
                    $tasksFetched.append(task)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TaskRow: View{
    @ObservedRealmObject var task: TaskItem
    var body: some View{
        
        HStack(spacing: 15){
            
            Menu{
                Button("Missed"){
                    $task.taskStatus.wrappedValue = .missed
                }
                Button("Completed"){
                    $task.taskStatus.wrappedValue = .completed
                }
            } label: {
                
                Circle()
                    .stroke(.gray)
                    .frame(width: 15, height: 15)
                    .overlay{
                        
                        Circle()
                            .fill(task.taskStatus == .missed ? .red : (task.taskStatus == .pending ? .yellow : .green))
                    }
                
            }
            VStack(alignment: .leading, spacing: 12){
                
                TextField("task nr 1", text: $task.taskTitle)
                
                if task.taskTitle != ""{
                    Picker(selection: .constant("")){
                        
                        DatePicker(selection: $task.taskDate, displayedComponents: .date){
                            
                        }
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .navigationTitle("Task Date")
                        
                    } label: {
                        
                        HStack{
                            Image(systemName: "calendar")
                            
                            Text(task.taskDate.formatted(date: .abbreviated, time: .omitted))
                        }
                    }
                }
            }
        }
    }
}
