//
//  RealmRepository.swift
//  HomeWork_20220915
//
//  Created by Misako Mimura on 2022/09/15.
//

//お気に入り機能
import Foundation
import RealmSwift


protocol RealmRepository {
    func favorite(write:TrendResult)
    func isFavorite(by:TrendResult) -> Bool
    func favoriteDelete(delete:TrendResult)
}

class RealmRepositoryImpl:RealmRepository {
    
    // Get the default Realm
    let realm = try! Realm()
    
    //シングルトン：使い回す
    private init(){
        
    }
    static let shared:RealmRepository = RealmRepositoryImpl()
    
    //書き込み
    func favorite(write:TrendResult){
        var trendEntity = TrendEntity()
        trendEntity.trendResult(with: write)
        try! realm.write {
            realm.add(trendEntity, update: .modified)
        }
    }
    
    //削除
    func favoriteDelete(delete:TrendResult){
        var check = delete.id
        let results = realm.objects(TrendEntity.self).filter("id == %@",check)
        try! realm.write {
            realm.delete(results)
        }
    }
    //確認：お気に入りに存在してるか
    func isFavorite(by:TrendResult) -> Bool {
        //idがない時の書き方
//        let result = realm.objects(TrendEntity.self).filter("title = \(by.title) AND overview = \(by.overview) AND poster_path = \(by.poster_path)").first
        let result = realm.object(ofType: TrendEntity.self, forPrimaryKey: by.id)
        if result == nil {
            return false
        } else {
            return true
        }
    }
    
}
