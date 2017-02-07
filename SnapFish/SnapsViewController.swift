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
        // Do any additional setup after loading the view.
        
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot)
            
            in
            
            print(snapshot)
            
            
            // Here something is changed from previous version .... value is considered to be type id so we have to describe it to NSDictionary and run following steps
            let snap = Snap()
            let snapshotValue = snapshot.value as? NSDictionary
            snap.imageURL = (snapshotValue?["imageURL"] as? String)!
            snap.from = (snapshotValue?["from"] as? String)!
            snap.descrip = (snapshotValue?["description"] as? String)!
            
            
            self.snaps.append(snap)
            
            self.tableView.reloadData()
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return snaps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        return cell
        
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
