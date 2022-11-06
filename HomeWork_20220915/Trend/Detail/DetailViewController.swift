//
//  DetailViewController.swift
//  HomeWork_20220915
//
//  Created by Misako Mimura on 2022/09/18.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBAction func viewImpression(_ sender: Any) {
        performSegue(withIdentifier: "detailToImpression", sender: nil)
    }
    //***********　↓  ↓　*************
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailOverview: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let viewModel:DetailViewModel = DetailViewModelImpl()
    
    var detailContents:TrendResult?
    //***********　↑  ↑　*************

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(detailContents ?? "")
        detailContents.map {
            var moviePosterPath:String
            detailTitle.text = $0.title
            detailOverview.text = $0.overview
//            detailOverview.sizeToFit()
//            detailTitle.sizeToFit()
//            stackView.sizeToFit()
            
            if let poster = $0.poster_path {
                moviePosterPath = "https://image.tmdb.org/t/p/w154/" + poster
                detailImage.sd_setImage(with: URL(string: moviePosterPath), placeholderImage: UIImage(named: "noimage"))
            } else {
                moviePosterPath = ""
            }
        }
//        scrollView.contentSize = stackView.frame.size
//        scrollView.flashScrollIndicators()
        // Do any additional setup after loading the view.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

