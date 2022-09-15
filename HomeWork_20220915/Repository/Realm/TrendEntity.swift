//
//  TrendEntity.swift
//  HomeWork_20220915
//
//  Created by Misako Mimura on 2022/09/25.
//

import Foundation
import RealmSwift

class TrendEntity: Object {
    @objc dynamic var id:Int = 0
    @objc dynamic var title = ""
    @objc dynamic var overview = ""
    @objc dynamic var poster_path:String?
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func trendResult(with:TrendResult){
        id = with.id
        title = with.title
        overview = with.overview
        poster_path = with.poster_path
    }
}
