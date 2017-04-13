//
//  ChatTableViewController.swift
//  SampleChatClient
//
//  Created by Gauri Tikekar on 4/12/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

import UIKit
import Parse

class ChatTableViewController: UITableViewController {

    @IBOutlet weak var chatTextField: UITextField!
    
    var chats: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        
        queryMessages()
 
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ChatTableViewController.onTimer), userInfo: nil, repeats: true)
    }
    
    func queryMessages() {
        let query = PFQuery(className:"Message")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil && objects != nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        //print(object.objectId)
                        let user_ = object["user"]
                        var username_ = ""
                        if user_ != nil {
                            username_ = (user_ as! PFUser).username ?? ""
                            
                        }
                        if object["text"] != nil {
                            self.chats.append(username_ + ": " + (object["text"] as! String))
                            //self.chats.append(object["text"] as! String)
                        }
                        
                        
                    }
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                print(error ?? "messages error")
            }
        }
    }
    
    func onTimer() {
        chats.removeAll()
        tableView.reloadData()
        
        queryMessages()
    }

    @IBAction func onSendClick(_ sender: Any) {
        let message_ = PFObject(className:"Message")
        message_["text"] = chatTextField.text
        message_["user"] = PFUser.current()
        message_.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                self.chats.append(self.chatTextField.text!)
                self.tableView.reloadData()
                self.chatTextField.text = ""
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
  
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return chats.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.text = chats[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
