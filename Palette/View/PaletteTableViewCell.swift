//
//  PaletteTableViewCell.swift
//  Palette
//
//  Created by Madison Kaori Shino on 7/16/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {

    
    //PROPERTIES
    var photo: UnsplashPhoto? {
        didSet {
            updateViews()
        }
    }
    
    //LOAD SUBVIEWS (4) ---------
    
    //LIFECYCLE
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpViews()
    }
    
    //CLASS METHODS
    func updateViews() {
        guard let photo = photo else { return }
        fetchAndSetImage(for: photo)
    }
    
    func fetchAndSetImage(for photo: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: photo) { (image) in
            DispatchQueue.main.async {
                self.paletteImageView.image = image
            }
        }
    }
    
    //ADD SUBVIEWS (3) ----------
    
    func addSubviews() {
        self.addSubview(paletteImageView)
        self.addSubview(paletteTitleLable)
    }
    
    //CONSTRAIN VIEW (2) --------
    
    func setUpViews() {
        addSubviews()
        let imageWidth = (contentView.frame.width - (SpacingConstants.outerHorizontalPadding * 2))
        paletteImageView.anchor(toProperties: contentView.topAnchor,
                                bottom: nil,
                                leading: contentView.leadingAnchor,
                                trailing: contentView.trailingAnchor,
                                topPadding: SpacingConstants.outerVerticalPadding,
                                bottomPadding: 0,
                                leadingPadding: SpacingConstants.outerHorizontalPadding,
                                tralingPadding: -SpacingConstants.outerHorizontalPadding,
                                width: imageWidth,
                                height: imageWidth)
        paletteTitleLable.anchor(toProperties: paletteImageView.bottomAnchor,
                                 bottom: nil,
                                 leading: contentView.leadingAnchor,
                                 trailing: contentView.trailingAnchor,
                                 topPadding: SpacingConstants.verticalObjectBuffer,
                                 bottomPadding: 0,
                                 leadingPadding: SpacingConstants.outerHorizontalPadding,
                                 tralingPadding: -SpacingConstants.outerHorizontalPadding,
                                 width: nil,
                                 height: SpacingConstants.oneLineElementHeight)
    }

    //DECLARE VIEW (1) ----------
    
    //IMAGE VIEW
    lazy var paletteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 50
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //TEXT LABEL
    lazy var paletteTitleLable: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //PALETTE BAR
    
}

/*
 programmatic restraints:
 0. Set initial view controller in App Delegate
 1. Declare view
 2. Constrain view
 3. Add subview
 4. Load subviews
 */

//lazy = dont hold in memory, only initialized when called.
