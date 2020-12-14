//
//  MainCell.swift
//  RSSReader
//
//  Created by Neskin Ivan on 09.12.2020.
//  Copyright © 2020 Neskin Ivan. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
    static let cellID = "Cell"
    var rssImageView: UIImage? = nil
    var blackWhiteImage: UIImage?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageNewsView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(item: Item) {
        titleLabel.text = item.title
        imageNewsView.image = item.image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
