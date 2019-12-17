//
//  BasePresenter.swift
//  Fintonic
//
//  Created by Juan Gerardo Cruz on 12/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

protocol BasePresenter {
    associatedtype View
    func attachView(delegate : View)
    func detachView()
    func destroy()
}
