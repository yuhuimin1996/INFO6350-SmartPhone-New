//
//  InstaImageCellData.swift
//  InstaWithoutDBAndCloud
//
//  Created by 于慧敏 on 4/22/23.
//

import Foundation
import RealmSwift


class InstaImageCelldata: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var Image: Data?
    
    override static func primaryKey() -> String? {
        return "title"
    }
}
