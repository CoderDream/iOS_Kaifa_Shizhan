//
//  BookCell.swift
//  BookTable
//
//  Created by CoderDream on 2018/12/10.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var introduceLabel: UILabel!
    
    // 从模型中取出数据，更新 view 内容
    func configWithBookModel(bookModel: BookModel) {
        nameLabel.text = bookModel.name
        priceLabel.text = bookModel.price
        introduceLabel.text = bookModel.introduce
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
