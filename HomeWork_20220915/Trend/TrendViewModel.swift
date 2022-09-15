//
//  TrendViewModel.swift
//  HomeWork_20220915
//
//  Created by Misako Mimura on 2022/09/15.
//

import Foundation

protocol TrendViewModel {
    func trendContent(completion:@escaping(Result<Bool,Error>) -> Void )
    func trendCount() -> Int
    func trendDetaileContent(indexPath:IndexPath) -> TrendResult
    func favoriteAt(row:Int)
    func isFavorite(at:TrendResult) -> Bool
}


//*********************************************
class TrendViewModelImpl:TrendViewModel {
    let tmdbTrendRepository:TmdbTrendRepository = TmdbTrendRepositoryImpl()
    let realmRepository:RealmRepository = RealmRepositoryImpl.shared
    var contentData:[TrendResult] = [TrendResult]()
    
    func trendContent(completion:@escaping(Result<Bool,Error>) -> Void ){
        tmdbTrendRepository.GetPath {
            //リザルト型に変更
            switch $0{
            case .success(let tmdbTrend):
                self.contentData = tmdbTrend.results
                completion(.success(true))
                print("")
            case .failure(let error):
                completion(.failure(error))
                print("")
            }
        }
    }
    
    func trendCount() -> Int{
        contentData.count
    }
    
    func trendDetaileContent(indexPath:IndexPath) -> TrendResult {
        contentData[indexPath.row]
    }
    
    
    func favoriteAt(row:Int){
        let rowAt = contentData[row]
        if realmRepository.isFavorite(by: rowAt){
            
            realmRepository.favoriteDelete(delete: rowAt)
//            print("動作確認")
        }else{
            realmRepository.favorite(write: rowAt)
            
        }
    }
    
    func isFavorite(at:TrendResult) -> Bool {
        realmRepository.isFavorite(by: at)
    }
}
