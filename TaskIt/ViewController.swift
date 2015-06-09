//
//  ViewController.swift
//  TaskIt
//
//  Created by Diego Valderrama on 2/9/15.
//  Copyright (c) 2015 Diego Valderrama. All rights reserved.
//

import UIKit
import CoreData

//UITableViewDataSource, UITableViewDelegate: Objective-C allows you to define protocols (protocols are defined in another class), which declare the methods expected to be used for a particular situation. Apple knows when to call the functions created according to protocols

//Conecting the tableView to the ViewControler as delegate and datasource it is giving the classes UITableViewDataSource and UITableViewDelegate access to the tableView. The IBOutlet gives access from the Viewcontroller to the storyboard.
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, TaskDetailViewControllerDelegate, AddTaskViewControllerDelegate {
   
    //This variable is used to hook up the tableview in the Main.storyboard into the view controller, so we are able to access it in code.
    @IBOutlet weak var tableView: UITableView!
    
    //Creates an instance of AppDelegate that gives acces to ManagedObjectContext to make updates to the entities
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    //To update the table view with coreData
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    //A dictionary that will stored the key and the value
    //var taskArray:[Dictionary<String,String>] = []
    
    //var taskArray:[TaskModel] = []
    //This multidimensional array will allocate completed and uncompleted tasks
    //var baseArray:[[TaskModel]] = []
    
    //to connect the tableview delegate and datasource to the class.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor (patternImage: UIImage (named: "Background")!)
        
        //Create the dictionary
        /*let task1:Dictionary<String, String> = ["task": "Study French", "subtask": "Verbs", "date": "01/14/2014"]
        let task2:Dictionary<String, String> = ["task": "Eat Dinner", "subtask": "Burgers", "date": "01/14/2014"]
        let task3:Dictionary<String, String> = ["task": "Gym", "subtask": "Leg day", "date": "01/14/2014"]
        
        taskArray = [task1, task2, task3]*/
        
        
        /*let date1 = Date.from(year: 2014, month: 05, day: 20)
        let date2 = Date.from(year: 2015, month: 01, day: 31)
        let date3 = Date.from(year: 2015, month: 02, day: 20)
        
        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: date1, completed:false)
        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: date2, completed:false)
        
        let taskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Leg Day", date: date3, completed:false)]
        
        //This array is used to allocate completed tasks
        var completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, completed: true)]
        
        baseArray = [taskArray, completedArray]*/
        
        //We can get values using keys
        /*println(task2["task"]!)//! indicates that Im wrapping the optional value. You would need to unwrap the optionals like this: taskDict["task"]! or cell.taskLabel.text!
        println(task2["subtask"])
        println(task2["date"])*/
        
        //This function recalls numberOfRowsInSections and cellForRowAtIndexPath and it will refresh the information. U can use self when accesing the own IBOutlets
        
        //CoreData
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
        self.tableView.reloadData()
        
    }
    
    //This function is called everytime this viewController is presented the main view controller on the screen
    override func viewDidAppear(animated: Bool) {
        //println("View did appear function")
        //super.viewDidAppear(animated)
        
        
        //Embed function
        //Block 1
        /*func sortByDate (taskOne:TaskModel, taskTwo: TaskModel) -> Bool {
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        taskArray = taskArray.sorted(sortByDate)*/
        //End Block 1
        
        //Block 2
        /*baseArray[0] = baseArray[0].sorted{
            (taskOne: TaskModel, taskTwo: TaskModel) -> Bool in//the "in" keyword means there is a block (or closure, same thing) coming after it.
            //Comparision logic here
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        //End Block 2
        
        //Blocl 1 and Block 2 are equivalents
        
        //Refresh the information of the table view
        self.tableView.reloadData()
        */
        
        //Core Data
        /*let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }

    //This function is called right before the new view controller is presented on the screen so it’s an optimal place to put the data that the details view controller will be displaying. It is also called for any Segue we have, that's why we need the if/else statements.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //println("prepareForSegue Called")
        
        /*if segue.identifier == "showTaskDetail" {
            //We are saying that a segue has a propertie destinationViewController know that this is a TaskDetailViewController instance. The propertie destinationViewController can changes depending on the transition we r transitioning to
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            
            //Tells which is the current row selected
            let indexPath = self.tableView.indexPathForSelectedRow()
            
            //Get the task selected
            let thisTask = baseArray[indexPath!.section][indexPath!.row]//We have to use exclamation ! because in this case indexPath is an optional
            detailVC.detailTaskModel = thisTask
            
            //We want to get the editing working. Like with adding a task, we need access to the ViewController instance, so we can add our task to the array. Let’s do that now in TaskDetailViewController
            detailVC.mainVC = self
        }
        else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
            
            addTaskVC.mainVC = self
            
        }*/
        //Core Data
        if segue.identifier == "showTaskDetail" {
            //We are saying that a segue has a propertie destinationViewController know that this is a TaskDetailViewController instance. The propertie destinationViewController can changes depending on the transition we r transitioning to
            let detailVC: TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
            
            //Tells which is the current row selected
            let indexPath = self.tableView.indexPathForSelectedRow()
            
            //Get the task selected
            let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as! TaskModel//We have to use exclamation ! because in this case indexPath is an optional
            detailVC.detailTaskModel = thisTask
            detailVC.delegate = self //Like all other delegates, we must set equal to self. We do this inside the prepareForSegue function because that's where we have access to detailVC.
        
        }
        else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as! AddTaskViewController
            addTaskVC.delegate = self //With this line of code the delegate is goona be called in AddTaskViewController
        }
    }
    
    //UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //return baseArray.count
        //Core Data
        return fetchedResultsController.sections!.count
    }
    
    //This function allows to define the number of rows will appear in the table view. There are several sections and each section has a number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //We can use sections
        /*if section == 0 {
            return 2
        }else{
            return 3
        }*/
        
        //Indicates how many rows are in the given section
        //return baseArray[section].count
        //Core Data
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    //Returns and instance of UITableViewCell. In the indexPath you can encapsulate the row and its section
    //This function is called as manyTimes as the number of rows has the tableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //We can use different prototype cells depending on the row
        /*if indexPath.row == 0
            //Use the first prototype Cell
        else if indexPath.row == 1
            //Use a different prototype Cell
        */
        //let taskDict:Dictionary = taskArray[indexPath.row]
        
        /*let thisTask = baseArray[indexPath.section][indexPath.row]//First get the section (0 or 1) then get the row
        //We are saying that the type of Class for cell is TaskCell
        //myCell is the identifier defined in the storyboard for the tableViewCell in the TableView
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        //reUsableCell means we r reusing a cell, generating it over and over
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subTask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        //println("Index is \(indexPath.row) Task is \(thisTask.task)")
        
        /*if indexPath.row == 0 {
            cell.taskLabel.text = "Task name"
            cell.descriptionLabel.text = "Task description"
            cell.dateLabel.text = "Due date"
        }else {
            cell.taskLabel.text = "Study French"
            cell.descriptionLabel.text = "Verbs in past and present"
            cell.dateLabel.text = "01/10/2014"
        }*/
        
        return cell*/
        //Core Data
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! TaskCell
        
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subtask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        return cell
    }

    //UITableViewDelegate
    //This function is called when we tab a specific row in a table view
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("Function table view didDeselectRowAtIndexPath \(indexPath.row)")
        //Make a transition to Segue showTaskDetail
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }
    
    //This function indicates the heigh for the header
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    //This function sets the names of the headers
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        /*if section == 0 {
            return "To Do"
        }else {
            return "Completed"
        }*/
        
        //CoreData
        //To correct the bug
        if fetchedResultsController.sections?.count == 1 {//only 1 type of tasks
            let task = fetchedResultsController.fetchedObjects![0] as! TaskModel
            return task.completed.boolValue ? "Completed" : "To Do"
        }
        return section == 0 ? "To Do" : "Completed"

    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    //This fucntion allows the ability to do somethign when deleting a task
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        /*
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        //Deleting a task from the ToDo section
        if indexPath.section == 0{
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: true)
            //Another option var newTask = thisTask as TaskModel
            //Adds to the completed array the swiped tasks
            baseArray[1].append(newTask)
        }else{
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: false)
            //Adds to the ToDo array the swiped tasks
            baseArray[0].append(newTask)
        }
        
        //removes the swiped task
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        
        tableView.reloadData()
        */
        //Option to delete a task: http://bitfountain.io/courses/complete-ios8/lectures/4125
        
        //CoreData
        /*let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        if indexPath.section == 0 {
           thisTask.completed = true
        }
        else{
            thisTask.completed = false
        }*/
        
        //To correct the bug
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        if thisTask.completed == 0 {
            thisTask.completed = 1
        } else {
            thisTask.completed = 0
        }
        
        //Save the changes maded
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }
    
    //Function to set the title when deleting tasks
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        /*if indexPath.section == 0 {
        return "Complete"
        } else {
        return "Uncomplete"
        }*/
        
        var task = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        
        if task.completed == 0 {
            return "Complete"
        }else { //if task.completed == 1 {
            return "Uncomplete"
        }
        
    }

    
    //Helper Functions
    
    func taskFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
    }
    
    //Passing a fetch request to acces all task model instances and order by date
    func getFetchedResultsController() -> NSFetchedResultsController {
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        
        return fetchedResultsController
        
    }
    
    //We need to implement the function controllDidChangeContext. This function is called when the NSFetchedResults controller detects changes made in the CoreData stack. Each time it detects changes, we want to reload the information in the tableView. This is easier then having to call reload ourselves throught the ViewController.
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()//Updates the information on the tableView when something changes
    }
    
    func taskDetailEdited() {
        showAlert()
    }
    
    // AddTaskViewControllerDelegate
    
    func addTaskCanceled(message: String) {
        showAlert(message: message)
    }
    func addTask(message: String) {
        showAlert(message: message)
    }
    
    func showAlert (message:String="congratulations"){ //Set a default message
        var alert = UIAlertController(title: "Change Made!", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    

}

