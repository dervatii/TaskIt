//
//  TaskModel.swift
//  TaskIt
//
//  Created by Diego Valderrama on 3/4/15.
//  Copyright (c) 2015 Diego Valderrama. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)//In case we want to use Objective-C later
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
