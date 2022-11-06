//
//  ViewController.swift
//  HomeWork_20220915
//
//  Created by Misako Mimura on 2022/09/15.
//
import SDWebImage
import UIKit
import RxSwift

class ViewController: UIViewController {
    
    //***********　↓ アウトレット＆インスタンス ↓　*************
    @IBOutlet weak var trendTableView: UITableView!
    
    var trendData:TmdbTrend?
    
    let viewModel:TrendViewModel = TrendViewModelImpl()
    
    //rxswift
    let disposeBag = DisposeBag()
    //    var detailContents = viewModel.trendDetaileContent(indexPath: IndexPath)
    //***********　↑  ↑　*************
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //テストクラッシュ
//        fatalError("Crash was triggered")
        
        //クロージャーバーション
//        viewModel.trendContent {
//            //            $0.mapError {}
//            switch $0{
//            case .success:
//                DispatchQueue.main.async {
//                    self.trendTableView.reloadData()
//                }
//            case .failure(let error):
//                print("エラー")
//            }
//        }
        
        //rxswift
        viewModel.trendContentRx().subscribe{
            //            $0.mapError {}
            switch $0{
            case .success:
                DispatchQueue.main.async {
                    self.trendTableView.reloadData()
                }
            case .failure(let error):
                print("エラー")
            }
        }
        .disposed(by: disposeBag)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    //タップしたときに呼ばれる関数
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "listToDetail", sender: trendData.results[indexPath.row])
        
        let trendLists = viewModel.trendDetaileContent(indexPath: indexPath)
        //        viewModel.trendContent {
        //            $0.mapError {}
        //            switch $0{
        //            case .success:
        //                print("成功")
        //
        //            case .failure(let error):
        //                print("エラー")
        //            }
        //        }
        //        print(trendLists[indexPath.row])
        
        //        detailContents.map {
        performSegue(withIdentifier: "listToDetail", sender: trendLists)
        //        }
        //        print(trendData)
        
        //        if let trendData = trendData {
        //            print(trendData.results[indexPath.row])
        //            performSegue(withIdentifier: "listToDetail", sender: trendData.results[indexPath.row])
        //        }
    }
    
    //遷移先が増えたときのための処理分岐
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listToDetail" {
            let detail = sender as! TrendResult
            let next = segue.destination as! DetailViewController
            next.detailContents = detail
        }
    }
    
}

extension ViewController:UITableViewDataSource {
    //テーブル：何行表示させるかの処理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.trendCount()
    }
    //テーブル：セルに何を表示させるかの処理
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var moviePosterPath:String
        
        
        //        let cell = trendTableView.dequeueReusableCell(withIdentifier: "trendCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendCell", for: indexPath) as! TrendTableViewCell
        //お気に入り機能：タグをつける
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(self.tapButton(_:)), for: .touchUpInside)
        
        
        let trendLists = viewModel.trendDetaileContent(indexPath: indexPath)
        
        //        trendLists.poster_path
        if let poster = trendLists.poster_path {
            moviePosterPath = "https://image.tmdb.org/t/p/w154/" + poster
        } else {
            moviePosterPath = ""
        }
        
        cell.contentName.text = trendLists.title
        //お気にい入りチェック
        if viewModel.isFavorite(at: trendLists){
            cell.favorite.image = UIImage(named: "favorite")
        } else {
//            cell.favorite.image = nil
            cell.favorite.image = UIImage(named: "grayFavorite")
        }
        
        cell.contentImage.sd_setImage(with: URL(string: moviePosterPath), placeholderImage: UIImage(named: "noimage"))
        
        return cell
    }
    
    //ボタンタップの処理
    @objc func tapButton(_ sender: UIButton){
        print("ボタンがタップされました。")
        var numRow = sender.tag
        viewModel.favoriteAt(row: numRow)
        
        //テーブル更新
        viewModel.trendContent {
            //            $0.mapError {}
            switch $0{
            case .success:
                DispatchQueue.main.async {
                    self.trendTableView.reloadData()
                }
            case .failure(let error):
                print("エラー")
            }
        }
    }
    
}

extension ViewController:UITableViewDelegate {
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


//extension String {
//    func a() -> Self{
//        return "aaaaaaaaaaaaaaa"
//    }
//}
