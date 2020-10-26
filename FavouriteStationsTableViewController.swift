//
//  FavouriteStationsTableViewController.swift
//  4Music
//
//  Created by Ivana Fidanovska on 10/16/20.
//  Copyright © 2020 Fidanovska. All rights reserved.
//

import UIKit
import CoreData

class FavouriteStationsTableViewController: UITableViewController{

    @IBOutlet var favouriteStations: UITableView!
    
    let favouriteArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var result:[MyList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favouriteStations.delegate = self
        favouriteStations.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetch()
        favouriteStations.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return result.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteStations.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! FavouritesTableViewCell
        
        let rslt = result[indexPath.row]
        cell.nameRadioLabel.text = rslt.radioName
        
        return cell
    }
    

    func fetch(){
        let request = NSFetchRequest<MyList>(entityName: "MyList")
        do {
            result = try context.fetch(request)
        }
        catch
        {
            print(error)
        }
    }
   
}
