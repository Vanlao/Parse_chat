//
//  ChatViewController.swift
//  Parse_chat
//
//  Created by Tu Pham on 10/4/18.
//  Copyright © 2018 Van Lao. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var Chat_field: UITextField!
    @IBOutlet weak var tableViewer: UITableView!
    var contentText = [PFObject]()
    let User = PFUser.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewer.delegate = self
        tableViewer.dataSource = self
        Chat_field.placeholder = "Type message here..."
        // Auto size row height based on cell autolayout constraints
        tableViewer.rowHeight = UITableView.automaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableViewer.estimatedRowHeight = 50
        //self.refresh()
        onTimer() //refresh every 5 second
        // Do any additional setup after loading the view.
    }
    //this block wil print out the text after you touch "send" button.
    @IBAction func onSend(_ sender: Any) {
        let Chatmessage = PFObject(className: "Message")
        
        Chatmessage["text"] = Chat_field.text ?? ""
        Chatmessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.Chat_field.text = ""
                self.refresh()
                
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return contentText.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //create a table cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatViewCell
        //customize cell.
        let text = contentText[indexPath.row]
        let textContent = text["text"] as! String
        if let user = text["User"] as? PFUser {
            // User found! update username label with username
            cell.UserName.text = user.username
        } else {
            // No user found, set default username
            cell.UserName.text = "🤖"
        }

        cell.chatMessage.text = textContent
        //return cell.
        return cell
    }
    //this function will retrieve the message typed in chat, then save it before show it on table view. It will also refresh itself.
    func refresh(){
        let querry = PFQuery(className: "Message")
        querry.order(byDescending: "createdAt")
        querry.includeKey("User")
        querry.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                print("objects found")
                
                if let objects = objects {
                    self.contentText = objects
                    self.tableViewer.reloadData() // call reload data here so that it's called only when your findObjectsInBackground finishes
                    
                }
            }
        }
    }
    @objc func onTimer() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        print("refreshed")
        refresh()
        // Add code to be run periodically
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
