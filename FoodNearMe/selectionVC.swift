//
//  selectionVC.swift
//  FoodNearMe
//
//  Created by Faisal Akhtar on 2017-04-10.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

class selectionVC: UITableViewController {
    var stores = [Store]()
    var spec_store = [Store]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-----------------SELECTIONVC-----------------------",self.stores)
        self.tableView.rowHeight = 230.0;
        self.tableView.dataSource = self;
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.spec_store.removeAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stores.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! selectionCellVC
        cell.store = self.stores[indexPath.row]
        DispatchQueue.main.async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.reloadData()
            }
        }
        
        return cell
        
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("going to the details view")
        self.spec_store.append(self.stores[indexPath.row])
        performSegue(withIdentifier: "detailsSeg", sender: self);
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailsSeg") {
            
            let viewController = segue.destination as! DetailsVC;
            viewController.spec_store = self.spec_store
        }
    }
    

}
