//
//  MarvelsCollectionViewController.swift
//  Fintonic
//
//  Created by Juan Gerardo Cruz on 12/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MarvelsCollectionViewController: UICollectionViewController {

    private var marvels = [Marvels]()
    var presenter: ShowMarvelPresenter?
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        indicator.style = .large
        indicator.color = .darkGray
        indicator.hidesWhenStopped = true
        return indicator
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setCollectionLayout()
        setIndicator()
        self.presenter?.showHeroes()
    }
    
    // MARK: - SettingNavigation
    
    private func setNavigation () {
        navigationItem.title = "Super Heroes"
        navigationController?.navigationBar.isTranslucent = false
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    // MARK: - SettingLayout
    
    private func setCollectionLayout() {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:3,left:2,bottom:0,right:2)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2 - 4, height: 170)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 2
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - SettingIndicator
    private func setIndicator () {
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }

 
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return marvels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MarvelsCollectionViewCell
        // Configure the cell
        cell.marvel = marvels[indexPath.row]
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         performSegue(withIdentifier: "segueDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetails" {
            guard let detailVC = segue.destination as? DetailsViewController,
                  let item =  collectionView.indexPathsForSelectedItems?.first else { return }
                  detailVC.marvels = marvels[item.row]
        }
    }
}


extension MarvelsCollectionViewController: ShowMarvelDelegate {
    
    func showProgress() {
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = .white
    }
    
    func hideProgress() {
        activityIndicator.stopAnimating()
    }
    
    func setHeroes(_ heroes: SuperHeroes) {
        marvels = heroes.superheroes
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
}
