//
//  SnapsViewController.swift
//  SnapFish
//
//  Created by Mac Owner on 2/6/17.
//  Copyright © 2017 Shashank. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var snaps : [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            tableView.dataSource = self
            tableView.delegate = self
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot)
            
            in
            
            print(snapshot)
            
            
            // Here something is changed from previous version .... value is considered to be type id so we have to describe it to NSDictionary and run following steps
            let snap = Snap()
            let snapshotValue = snapshot.value as? NSDictionary
            snap.imageURL = (snapshotValue?["imageURL"] as? String)!
            snap.from = (snapshotValue?["from"] as? String)!
            snap.descrip = (snapshotValue?["description"] as? String)!
            
            snap.key = snapshot.key
            
            snap.uuid = (snapshotValue?["uuid"] as? String)!
            self.snaps.append(snap)
            
            self.tableView.reloadData()
        })
        
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childRemoved, with: {(snapshot)
            
            in
            
            print(snapshot)
            
            var index = 0
            for snap in self.snaps {
            
                if snap.key == snapshot.key {
                    self.snaps.remove(at: index)
                
                }
                index += 1
            
            
            }
            
            self.tableView.reloadData()
            
            // Here something is changed from previous version .... value is considered to be type id so we have to describe it to NSDictionary and run following steps
            
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0 {
            return 1
        } else {
        return snaps.count
    }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if snaps.count == 0 {
            cell.textLabel?.text = "😟You have no Snaps😟"
            
        }else {
        
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        
        performSegue(withIdentifier: "viewsnapsegue", sender: snap)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewsnapsegue" {
        let nextVC = segue.destination as! ViewSnapViewController
        nextVC.snap = sender as! Snap
        }
    }
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
