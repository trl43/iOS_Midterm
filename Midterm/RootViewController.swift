//
//  RootViewController.swift
//  Midterm
//
//  Created by Locker,Todd (TRL43) on 11/2/16.
//  Copyright © 2016 Locker,Todd. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        self.pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        
        // Guard added by TRL43
        guard let pvc = self.pageViewController else {
            print("ERROR: Could not unwrap the pageViewController")
            return
        }
        
        pvc.delegate = self
        
        // Guard added by TRL43
        guard let board = self.storyboard else {
            print("ERROR: Could not unwrap storyboard")
            return
        }
        
        // Guard added by TRL43
        guard let ind = self.modelController.viewControllerAtIndex(0, storyboard: board) else {
            print("ERROR: Could not unwrap viewControllerAtIndex")
            return
        }

        let startingViewController: DataViewController = ind
        let viewControllers = [startingViewController]
        pvc.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })

        pvc.dataSource = self.modelController

        self.addChildViewController(pvc)
        self.view.addSubview(pvc.view)

        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
        var pageViewRect = self.view.bounds
        if UIDevice.current.userInterfaceIdiom == .pad {
            pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
        }
        pvc.view.frame = pageViewRect

        pvc.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            _modelController = ModelController()
        }
        
        // Guard added by TRL43
        guard let mc = _modelController else {
            print("ERROR: Could not unwrap _modelController")
            return ModelController()
        }
        
        return mc
    }

    var _modelController: ModelController? = nil

    // MARK: - UIPageViewController delegate methods

    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        // Guard added by TRL43
        guard let pvc = self.pageViewController else {
            print("ERROR: No pageViewController")
            return .none
        }
        
        if (orientation == .portrait) || (orientation == .portraitUpsideDown) || (UIDevice.current.userInterfaceIdiom == .phone) {
            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to true, so set it to false here.
            // Guard added by TRL43
            guard let currentViewController = pvc.viewControllers?[0] else {
                print("ERROR: Could not get index 0 of viewController")
                return .none
            }
            let viewControllers = [currentViewController]
            pvc.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

            pvc.isDoubleSided = false
            return .min
        }

        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        // Guard added by TRL43
        guard let currentViewController = pvc.viewControllers![0] as? DataViewController else {
            print("ERROR Could not complete cast")
            return .none
        }
        var viewControllers: [UIViewController]? = nil

        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            if let nextViewController = self.modelController.pageViewController(pvc, viewControllerAfter: currentViewController) {
                viewControllers = [currentViewController, nextViewController]
            }
        } else {
            if let previousViewController = self.modelController.pageViewController(pvc, viewControllerBefore: currentViewController) {
                viewControllers = [previousViewController, currentViewController]
            }
        }
        pvc.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
        return .mid
    }


}

