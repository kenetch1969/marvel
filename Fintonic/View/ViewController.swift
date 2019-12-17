//
//  ViewController.swift
//  Fintonic
//
//  Created by Juan Gerardo Cruz on 12/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var btnGetStarted: UIButton!
    
    private var scrollWidth: CGFloat! = 0.0
    private var scrollHeight: CGFloat! = 0.0

    private var titles = ["VALOR","HONOR","INTELIGENCIA"]
    private var imgs = ["Avengers","CaptainAmerica","Iron Man"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavigation()
        setPage()
        setButton()
    }
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    private func setNavigation() {
        navigationItem.title = "Avenger, Unidos!"
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setPage() {
         self.view.layoutIfNeeded()
         self.scrollView.delegate = self
         scrollView.isPagingEnabled = true
         scrollView.showsHorizontalScrollIndicator = false
         scrollView.showsVerticalScrollIndicator = false

         //crete the slides and add them
         var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

         for index in 0..<titles.count {
             frame.origin.x = scrollWidth * CGFloat(index)
             frame.size = CGSize(width: scrollWidth, height: scrollHeight)

             let slide = UIView(frame: frame)

             //subviews
             let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
             imageView.frame = CGRect(x:0,y:0,width:300,height:300)
             imageView.contentMode = .scaleAspectFill
             imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
           
             let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+30,width:scrollWidth-64,height:30))
             txt1.textAlignment = .center
             txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
             txt1.text = titles[index]

             slide.addSubview(imageView)
             slide.addSubview(txt1)
             scrollView.addSubview(slide)

         }

         //set width of scrollview to accomodate all the slides
         scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

         //disable vertical scroll/bounce
         self.scrollView.contentSize.height = 1.0

         //initial state
         pageControl.numberOfPages = titles.count
         pageControl.currentPage = 0
    }
    
    private func setButton() {
        self.btnGetStarted.layer.cornerRadius = 13
    }
    
    //indicator
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }

    
    @IBAction func ingresarAction(_ sender: UIButton) {
        performSegue(withIdentifier: "segueHeroes", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueHeroes" {
            guard let viewShowMarvel = segue.destination as? MarvelsCollectionViewController else { return }
            let network = MarvelUrlAPI()
            let presenter = ShowMarvelPresenter(model: network)
            presenter.attachView(delegate: viewShowMarvel)
            viewShowMarvel.presenter = presenter
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
}
