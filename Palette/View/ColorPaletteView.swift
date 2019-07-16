//
//  ColorPaletteView.swift
//  Palette
//
//  Created by Madison Kaori Shino on 7/16/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class ColorPaletteView: UIView {
    
    //PROPERTIES
    var colors: [UIColor] {
        didSet {
            buildColorBricks()
        }
    }
    
    init(colors: [UIColor] = [], frame: CGRect = .zero) {
        self.colors = colors
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    //LOAD SUBVIEWS (4) ------------
    //ADD SUBVIEWS (3) -------------
    
    //LIFECYCLE
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpStackView()
    }
    
    //CONSTRAIN VIEWS (2) ----------
    
    private func setUpStackView() {
        addSubview(colorStackView)
        colorStackView.anchor(toProperties: topAnchor,
                              bottom: bottomAnchor,
                              leading: leadingAnchor,
                              trailing: trailingAnchor,
                              topPadding: 0,
                              bottomPadding: 0,
                              leadingPadding: 0,
                              tralingPadding: 0)
        buildColorBricks()
    }
    
    //DECLARE VIEWS (1) ------------
    
    //STACK VIEW
    lazy var colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        return stackView
    }()
    
    //COLOR VIEWS
    private func generateColorBrick(for color: UIColor) -> UIView {
        let colorBrick = UIView()
        colorBrick.backgroundColor = color
        return colorBrick
    }
    
    private func buildColorBricks() {
        resetColorBricks()
        for color in colors {
            let colorBrick = generateColorBrick(for: color)
            self.addSubview(colorBrick)
            self.colorStackView.addArrangedSubview(colorBrick)
        }
        self.layoutIfNeeded()
    }
    
    private func resetColorBricks() {
        for subview in colorStackView.arrangedSubviews {
            self.colorStackView.removeArrangedSubview(subview)
        }
    }
    
}
