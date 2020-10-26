//
//  MenuTableViewController.swift
//  4Music
//
//  Created by Ivana Fidanovska on 10/14/20.
//  Copyright © 2020 Fidanovska. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case home
    case favourites
}

class MenuTableViewController: UITableViewController {
    
    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else {
            return
        }
        
        dismiss(animated: true) {[weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
          
        }
    }

}
