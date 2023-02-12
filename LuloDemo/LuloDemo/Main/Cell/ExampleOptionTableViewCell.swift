//
//  ExampleOptionTableViewCell.swift
//  LuloDemo
//
//  Created by Juan Hurtado on 5/02/23.
//

import UIKit

class ExampleOptionTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
}
