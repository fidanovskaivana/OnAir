//
//  Support.swift
//  4Music
//
//  Created by Ivana Fidanovska on 10/22/20.
//  Copyright © 2020 Fidanovska. All rights reserved.
//

import Foundation
import CoreData
import UIKit

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

func saveContext() {
    
    if context.hasChanges
    {
        do{
            try context.save()
        }
        catch
        {
        print("Error")
        }
    }
}
