//
//  ShowMarvelPresenter.swift
//  Fintonic
//
//  Created by Juan Gerardo Cruz on 12/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

protocol ShowMarvelDelegate{
    func showProgress()
    func hideProgress()
    func setHeroes(_ heroes: SuperHeroes)
}

class ShowMarvelPresenter: BasePresenter {
    typealias View = ShowMarvelDelegate
    private var delegate: ShowMarvelDelegate?
    private var model: Networks
    
    init(model: Networks) {
        self.model = model
    }
    
    func attachView(delegate: ShowMarvelDelegate) {
        self.delegate = delegate
    }
    
    func detachView() {
        self.delegate = nil
    }
    
    func destroy() {
        
    }
    
    func showHeroes(){
       self.delegate?.showProgress()
        model.getMarvelsHeroes { (heroes) in
            self.delegate?.setHeroes(heroes)
        }
    }
}
