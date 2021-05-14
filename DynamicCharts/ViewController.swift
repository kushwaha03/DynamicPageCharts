//
//  ViewController.swift
//  DynamicCharts
//
//  Created by Sauda Sadaf on 2021-05-13.
//

import UIKit

class ViewController: UIViewController{

    

    @IBOutlet weak var contentView: UIView!
    let dataSource = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ConfigPageViewController()
    }
    func ConfigPageViewController() {
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: PageViewController.self)) as? PageViewController else {
            return
        }
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pageViewController.view)
        
        let views : [String:Any] = ["pageView": pageViewController.view]
        

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        guard let startingViewController =  DetailViewControllerAt(index: currentViewControllerIndex) else {
            return
        }
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
        
    }
    func DetailViewControllerAt(index: Int) -> GraphViewController?{
        
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        guard let GraphViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: GraphViewController.self)) as? GraphViewController else {
            return nil
        }
        GraphViewController.index = index
        GraphViewController.monthName = dataSource[index]

        return GraphViewController
    }
    


}

extension ViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource  {
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
       return currentViewControllerIndex
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
      return  dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let GraphViewController = viewController as? GraphViewController
        guard var  currentIndex =  GraphViewController?.index else {
            return nil
        }
        if currentIndex == 0 {
            return nil

        }
        currentIndex -= 1
        
        return DetailViewControllerAt(index: currentIndex)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let GraphViewController = viewController as? GraphViewController
        guard var  currentIndex =  GraphViewController?.index else {
            return nil
        }
        if currentIndex == dataSource.count {
            return nil

        }
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        return DetailViewControllerAt(index: currentIndex)
        
    }
}
