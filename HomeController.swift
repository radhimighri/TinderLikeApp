//
//  HomeController.swift
//  TinderLikeApp
//
//  Created by Radhi Mighri on 26/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit


class HomeCotroller: UIViewController {
    
    //MARK:- Properties
    private let topStack = HomeNavigationStackView()
    
    private let deckView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        return view
    }()
    
    let bottomStack = BottomControlsStackView()

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        configureCards()
    }
    
    //MARK:- Helpers Functions
    func configureCards(){
        
        let user1 = User(name: "Jane Doe", age: 22, images: [#imageLiteral(resourceName: "jane3"), #imageLiteral(resourceName: "lady5c")])
        let user2 = User(name: "Mogan Angela", age: 25, images: [#imageLiteral(resourceName: "kelly2"), #imageLiteral(resourceName: "jane2")])

        let cardView1 = CardView(viewModel: CardViewModel(user: user1))
        let cardView2 = CardView(viewModel: CardViewModel(user: user2))


        
        deckView.addSubview(cardView1)
        deckView.addSubview(cardView2)
        
        cardView1.fillSuperview()
        cardView2.fillSuperview()
    }
    func configureUI() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [topStack, deckView, bottomStack])
        stack.axis = .vertical
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                        bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)

        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView)
    }

}

