//
//  TrendTableViewCell.swift
//  HomeWork_20220915
//
//  Created by Misako Mimura on 2022/09/18.
//

import UIKit

class TrendTableViewCell: UITableViewCell {
    
    //***********　アウトレット　*************
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var contentName: UILabel!
    
    @IBOutlet weak var favorite: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            
        if selected {
//            print("選んだセルデータを取得したい")
        }
        // Configure the view for the selected state
    }
    
    

}
