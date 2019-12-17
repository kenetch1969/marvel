//
//  DetailsViewController.swift
//  Fintonic
//
//  Created by Juan Gerardo Cruz on 12/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var poderesTextView: UITextView!
    @IBOutlet weak var habilidadesTextView: UITextView!
    @IBOutlet weak var gruposTextView: UITextView!
    
    var marvels: Marvels?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigation()
        setView()
        setProperties()
    }
    
    private func setProperties() {
        guard let heroe = marvels else { return }
        poderesTextView.text = heroe.power
        habilidadesTextView.text = heroe.abilities
        gruposTextView.text = heroe.groups
    }
    
    private func setNavigation() {
       navigationItem.title = "Super Heroes"
       navigationController?.navigationBar.isTranslucent = false
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func setView() {
        detailView.layer.cornerRadius = 13
        detailView.layer.borderWidth = 1.0
        detailView.layer.borderColor = UIColor.lightGray.cgColor

        detailView.layer.backgroundColor = UIColor.white.cgColor
        detailView.layer.shadowColor = UIColor.gray.cgColor
        detailView.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        detailView.layer.shadowRadius = 2.0
        detailView.layer.shadowOpacity = 1.0
        detailView.layer.masksToBounds = false
    }
}
