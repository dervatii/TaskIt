//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Diego Valderrama on 2/18/15.
//  Copyright (c) 2015 Diego Valderrama. All rights reserved.
//

import UIKit
import CoreData


protocol AddTaskViewControllerDelegate {
    func addTask(message: String)
    func addTaskCanceled(message: String)
}

class AddTaskViewController: UIViewController {

    //We will use this propertie to pass an instance of the main ViewController when we segue.
    //var mainVC: ViewController!
    
    //setup a property for our delegate
    var delegate: AddTaskViewControllerDelegate?
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor (patternImage: UIImage (named: "Background")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function allows to recognize when the user want to create a new task
    @IBAction func addTaskButtonTapped(sender: UIButton) {
        //Get the values for the new task
        /*var task = TaskModel(task: taskTextField.text, subTask: subtaskTextField.text, date: dueDatePicker.date, completed: false)
        
        //In swift we dont use protocols like we did in objective c to pass the new object back to previews VC, instead we have full access to the previews VC. Its kind of easier :) and less code.
        mainVC.baseArray[0].append(task)
        
        //Removes the current view from the stack
        */
        //For Core Data
        
        //Create an instance of AppDelegate
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        let managedObjectContext = appDelegate.managedObjectContext
        
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        
        //Creates a TaskModel instance
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        //The task is capitalized when is created or no depending on the settings configuration
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
            task.task = taskTextField.text.capitalizedString //Capitalize the fist letter
        } else {
            task.task = taskTextField.text
        }
        
        //The task is created as completed or no depending on the settings configuration
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewToDoKey) == true {
            task.completed = true
        }
        else {
            task.completed = false
        }
        
        //task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        //task.completed = false
        
        appDelegate.saveContext()
        
        //To get back all the instances.
        //To make sure we saved the changes to CoreData we can use a fetchRequest to view all of the items from coreData.
        //A fetch request takes one parameter, the entity name. Once we execute the fetch request, it will retrieve all saved instances of the Entity name we pass in. When making this request we also must pass in an NSError instance which we can print if there is an issue saving to coreData.
        var request = NSFetchRequest(entityName: "TaskModel")//Request all entities or instances of task model
        var error:NSError? = nil
        
        //Finally, we can use a for loop to iterate over the returned array from our query.
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        
        
        //We finish the functionality for the addTaskButtonTapped function by calling dismissViewControllerAnimated() to remove the current ViewController and present the main ViewController on the screen.
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("task Added")
    }

    @IBAction func cancelButtonTapped(sender: UIButton) {
        
        //We dont have acces to the self.navigationController becasuse we r not inside a navigation controller and that is cause we use modal transition. The current view controller can be responsible for removing itself
        self.dismissViewControllerAnimated(true, completion: nil)//We dont need a completion block, that is used to run a block of code when the transition is occuring
        
        delegate?.addTaskCanceled("Task was not added")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
