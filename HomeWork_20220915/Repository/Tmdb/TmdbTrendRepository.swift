//
//  TmdbTrendRepository.swift
//  HomeWork_20220915
//
//  Created by Misako Mimura on 2022/09/15.
//

import Foundation

//***********　プロトコル:使っていいよBOX　*************
protocol TmdbTrendRepository {
    func GetPath(completion:@escaping(Result<TmdbTrend,Error>) -> Void)
}

/*　構造体（クラスに近い）：データセット的なJSON形式で渡ってきたデータを格納。*/

struct TmdbTrend:Codable {
    let page:Int
    let results:[TrendResult]
}

//名前・あらすじ・ポスターパス
struct TrendResult:Codable {
    let id:Int
    let title:String
    let overview:String
    let poster_path:String?
}

//***********　クラス　*************
class TmdbTrendRepositoryImpl:TmdbTrendRepository {
    
    //カテゴリー all/movie/tv/person
    //期間 day/week
    /*参照：https://developers.themoviedb.org/3/trending/get-trending*/
    var trendCategory = "movie"
    var trendPeriod = "week"
    
    //hoge:string,completion ストリングを渡す場合
    //Result<TmdbTrend,Error>リザルト型に変更
    func GetPath(completion:@escaping(Result<TmdbTrend,Error>) -> Void){
        
//        let aaa = trendCategory.a()
        
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/"+trendCategory+"/"+trendPeriod+"?api_key=e5b4de861fb39e30878b374663ec3d03&language=ja-JP") else { return }
        
        let request = URLRequest(url: url)
        let decoder:JSONDecoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
            //guard let data = data else { return } swift5.7 xcode14からで省略可能に
            
//            error.map {
//                completion(.failure($0))
//            }
            
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else { return }
            
            do {
                let DecodeData:TmdbTrend = try decoder.decode(TmdbTrend.self, from: data)
//                print(DecodeData)
                //リザルト型に変更
                completion(.success(DecodeData))
            } catch let e {
                print("**JSON Decode Error:\(e)")
                //リザルト型に変更
//                fatalError()
                completion(.failure(e))
            }
        }
        task.resume()
    }
    
}
