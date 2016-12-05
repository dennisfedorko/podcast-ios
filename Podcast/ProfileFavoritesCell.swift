//
//  ProfileFavoritesCell.swift
//  Podcast
//
//  Created by Drew Dunne on 11/30/16.
//  Copyright © 2016 Cornell App Development. All rights reserved.
//

import UIKit

class ProfileFavoritesCell: UITableViewCell {
    
    let height: CGFloat = 70
    let contentPaddingX:CGFloat = 6.0
    let contentPaddingY:CGFloat = 3.0
    
    var nameLabel: UILabel!
    var containerView: UIView!
    var podImage: UIImageView!
    
    var episode: Episode? {
        didSet {
            guard let episode = episode else { return }
            nameLabel.text = episode.title
            podImage.image = episode.smallArtworkImage
        }
    }
    
    // Mark: Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        frame.size.height = height+2*contentPaddingY
        backgroundColor = UIColor.podcastWhiteDark
        selectionStyle = .none
        
        containerView = UIView(frame: CGRect.zero)
        containerView.backgroundColor = UIColor.podcastWhite
        contentView.addSubview(containerView)
        
        podImage = UIImageView(frame: CGRect.zero)
        podImage.image = #imageLiteral(resourceName: "fillerImage")
        containerView.addSubview(podImage)
        
        nameLabel = UILabel(frame: CGRect.zero)
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = .podcastBlack
        nameLabel.numberOfLines = 2
        containerView.addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        containerView.frame = CGRect(x: 0, y: contentPaddingY, width: frame.width, height: height)
        
        let containSize = containerView.frame.size
        let cellPadding:CGFloat = 12.0
        let spacing:CGFloat = 12.0
        
        let imageHeight:CGFloat = (height-2*cellPadding)
        let labelWidth:CGFloat = containSize.width - 2*cellPadding - imageHeight - spacing
        let labelHeight:CGFloat = 34
        podImage.frame = CGRect(x: cellPadding, y: cellPadding, width: imageHeight, height: imageHeight)
        nameLabel.frame = CGRect(x: cellPadding+imageHeight+spacing, y: 1.5*cellPadding, width: labelWidth, height: labelHeight)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        containerView.backgroundColor = selected ? UIColor.podcastWhiteLight : UIColor.podcastWhite
    }
    
}
