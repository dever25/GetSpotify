//
//  TableCell.swift
//  GetSpotiAPI
//
//  Created by Дмитрий Рудаков on 16.07.2021.
//

import UIKit

class TableCell: UITableViewCell {

    let label = UILabel()
    let cellImage = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 0,
                                                                     bottom: 2, right: 0))
    }
    
    internal func configureCell() {
        label.translatesAutoresizingMaskIntoConstraints = false
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.contentMode = .scaleAspectFit

        self.backgroundColor = .clear
        self.contentView.addSubview(label)
        self.contentView.addSubview(cellImage)
        
        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            cellImage.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            cellImage.widthAnchor.constraint(equalTo: self.contentView.heightAnchor),
            
            label.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -40)
        ])
    }
}
