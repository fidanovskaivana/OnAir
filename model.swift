//
//  model.swift
//  4Music
//
//  Created by Ivana Fidanovska on 10/21/20.
//  Copyright © 2020 Fidanovska. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MyList: NSManagedObject {
    
    @NSManaged var image: UIImage?
    @NSManaged var radioName: String?
    @NSManaged var url: String?
}
