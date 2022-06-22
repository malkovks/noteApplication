//
//  NoteData+CoreDataProperties.swift
//  Note
//
//  Created by Константин Малков on 30.05.2022.
//
//

import Foundation
import CoreData


extension NoteData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteData> {
        return NSFetchRequest<NoteData>(entityName: "NoteData")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?

}

extension NoteData : Identifiable {

}
