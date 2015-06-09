//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Diego Valderrama on 2/16/15.
//  Copyright (c) 2015 Diego Valderrama. All rights reserved.
//

import UIKit

@objc protocol TaskDetailViewControllerDelegate {
    optional func taskDetailEdited()
}

class TaskDetailViewController: UIViewController {
    
    var detailTaskModel: TaskModel!
    
    var delegate:TaskDetailViewControllerDelegate?
    
    //We want to get the editing working. Like with adding a task, we need access to the ViewController instance, so we can add our task to the array. Let’s do that now in TaskDetailViewController
    //var mainVC: ViewController! R//emoved for core data
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor (patternImage: UIImage (named: "Background")!)
        
        println("detailTaskModel \(self.detailTaskModel.task)")
        self.taskTextField.text = detailTaskModel.task
        self.subTaskTextField.text = detailTaskModel.subtask
        self.dueDatePicker.date = detailTaskModel.date

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        //Pops the current vie controller off the navigation controller stack
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //This function is used to update tasks
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        
        /*var task = TaskModel(task: taskTextField.text, subTask: subTaskTextField.text, date: dueDatePicker.date, completed: false)
        
        //Update the task array
        mainVC.baseArray[0][mainVC.tableView.indexPathForSelectedRow()!.row] = task
        
        //Pops the current vie controller off the navigation controller stack
        self.navigationController?.popViewControllerAnimated(true)*/
        
        //Core Data
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        detailTaskModel.task = taskTextField.text
        detailTaskModel.subtask = subTaskTextField.text
        detailTaskModel.date = dueDatePicker.date
        detailTaskModel.completed = detailTaskModel.completed
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
        delegate?.taskDetailEdited!()
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
