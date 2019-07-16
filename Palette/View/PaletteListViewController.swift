//
//  PaletteListViewController.swift
//  Palette
//
//  Created by Madison Kaori Shino on 7/16/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteListViewController: UIViewController {
    
    //SOURCE OF TRUTH
    var photos: [UnsplashPhoto] = []
    
    //VIEW PROPERTIES
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    //ADD SUBVIEWS TO VIEW (4) ---------
    
    //LIFECYCLE
    override func loadView() {
        super.loadView()
        addSubViews()
        constrainStackView()
        constrainTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureTableView()
        searchForCategory(.featured)
    }

    
    //ADD SUBVIEWS WITH HELPER FUNCTIONS (3) ---------
    
    func addSubViews() {
        self.view.addSubview(featuredButton)
        self.view.addSubview(randomButton)
        self.view.addSubview(doubleRainbowButton)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(paletteTableView)
    }
    
    func searchForCategory(_ route: UnsplashRoute) {
        UnsplashService.shared.fetchFromUnsplash(for: route) { (photos) in
            DispatchQueue.main.async {
                guard let photos = photos else { return }
                self.photos = photos
                self.paletteTableView.reloadData()
            }
        }
    }
    
    //CONSTRAIN VIEWS (2) ----------
    
    func constrainStackView() {
        buttonStackView.addArrangedSubview(featuredButton)
        buttonStackView.addArrangedSubview(doubleRainbowButton)
        buttonStackView.addArrangedSubview(randomButton)
        buttonStackView.anchor(toProperties: safeArea.topAnchor,
                               bottom: nil,
                               leading: safeArea.leadingAnchor,
                               trailing: safeArea.trailingAnchor,
                               topPadding: SpacingConstants.margin,
                               bottomPadding: SpacingConstants.margin,
                               leadingPadding: SpacingConstants.margin,
                               tralingPadding: -SpacingConstants.margin)
    }
    
    func constrainTableView() {
        paletteTableView.anchor(toProperties: buttonStackView.bottomAnchor,
                                bottom: safeArea.bottomAnchor,
                                leading: safeArea.leadingAnchor,
                                trailing: safeArea.trailingAnchor,
                                topPadding: SpacingConstants.margin,
                                bottomPadding: SpacingConstants.margin,
                                leadingPadding: SpacingConstants.margin,
                                tralingPadding: -SpacingConstants.margin)
    }
    
    //DECLARE VIEWS (1) ------------
    
    //TOP MENU BUTTONS
    let featuredButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Featured", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Random", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let doubleRainbowButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Double Rainbow", for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    //TABLE VIEW
    let paletteTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    func configureTableView() {
        paletteTableView.delegate = self
        paletteTableView.dataSource = self
        paletteTableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "paletteCell")
        paletteTableView.allowsSelection = false
    }
}

//TABLE VIEW DATA SOURCE
extension PaletteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paletteCell", for: indexPath) as! PaletteTableViewCell
        let photo = photos[indexPath.row]
        cell.photo = photo
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageViewSpace: CGFloat = (view.frame.width - (2 * SpacingConstants.outerHorizontalPadding))
        let textLabelSpace: CGFloat = SpacingConstants.oneLineElementHeight
        let outerVerticalSpace: CGFloat = (2 * SpacingConstants.outerVerticalPadding)
        let verticalPadding: CGFloat = (3 * SpacingConstants.verticalObjectBuffer)
        return imageViewSpace + textLabelSpace + outerVerticalSpace + verticalPadding
    }
}


/*
 programmatic restraints:
 0. Set initial view controller in App Delegate
 1. Declare view
 2. Constrain view
 3. Add subview
 4. Load subviews
 */
