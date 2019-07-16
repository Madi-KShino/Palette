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
        fetchAndSetColors(for: photo)
        paletteTitleLabel.text = photo.description
    }
    
    func fetchAndSetImage(for photo: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: photo) { (image) in
            DispatchQueue.main.async {
                self.paletteImageView.image = image
            }
        }
    }
    
    func fetchAndSetColors(for photo: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: photo.urls.regular) { (colors) in
            DispatchQueue.main.async {
                guard let colors = colors else { return }
                self.colorPaletteView.colors = colors
            }
        }
    }
    
    //ADD SUBVIEWS (3) ----------
    
    func addSubviews() {
        self.addSubview(paletteImageView)
        self.addSubview(paletteTitleLabel)
        self.addSubview(colorPaletteView)
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
        paletteTitleLabel.anchor(toProperties: paletteImageView.bottomAnchor,
                                 bottom: nil,
                                 leading: contentView.leadingAnchor,
                                 trailing: contentView.trailingAnchor,
                                 topPadding: SpacingConstants.verticalObjectBuffer,
                                 bottomPadding: 0,
                                 leadingPadding: SpacingConstants.outerHorizontalPadding,
                                 tralingPadding: -SpacingConstants.outerHorizontalPadding,
                                 width: nil,
                                 height: SpacingConstants.oneLineElementHeight)
        colorPaletteView.anchor(toProperties: paletteTitleLabel.bottomAnchor,
                                bottom: contentView.bottomAnchor,
                                leading: contentView.leadingAnchor,
                                trailing: contentView.trailingAnchor,
                                topPadding: SpacingConstants.verticalObjectBuffer,
                                bottomPadding: SpacingConstants.outerVerticalPadding,
                                leadingPadding: SpacingConstants.outerHorizontalPadding,
                                tralingPadding: -SpacingConstants.outerHorizontalPadding,
                                width: nil,
                                height: SpacingConstants.twoLineElementHeight)
        colorPaletteView.clipsToBounds = true
        colorPaletteView.layer.cornerRadius = (SpacingConstants.twoLineElementHeight / 2)
    }

    //DECLARE VIEW (1) ----------
    
    //IMAGE VIEW
    lazy var paletteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = contentView.frame.height / 50
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //TEXT LABEL
    lazy var paletteTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //PALETTE VIEW
    lazy var colorPaletteView: ColorPaletteView = {
        let paletteView = ColorPaletteView()
        return paletteView
    }()
    
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
