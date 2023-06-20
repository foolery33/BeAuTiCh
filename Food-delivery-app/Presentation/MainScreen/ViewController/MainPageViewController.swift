//
//  MainPageViewController.swift
//  Food-delivery-app
//
//  Created by Nikita Usov on 08.06.2023.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    private let viewModel: MainViewModel
    var onSwipeAction: (() -> ())?
    
    private var currentIndex: Int = 0 {
        didSet {
            print(currentIndex)
        }
    }
    private var nextIndex: Int = 0
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        currentIndex = viewModel.selectedDayIndex
        super.init(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var pages: [UIViewController] = {
        return [
            self.getScheduleViewController(weekdayIndex: 0),
            self.getScheduleViewController(weekdayIndex: 1),
            self.getScheduleViewController(weekdayIndex: 2),
            self.getScheduleViewController(weekdayIndex: 3),
            self.getScheduleViewController(weekdayIndex: 4),
            self.getScheduleViewController(weekdayIndex: 5),
            self.getScheduleViewController(weekdayIndex: 6)
        ]
    }()
    
    private func getScheduleViewController(weekdayIndex: Int) -> ScheduleViewController {
        return ScheduleViewController(serviceNotes: viewModel.weekServiceNotes[weekdayIndex], viewModel: viewModel)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        setViewControllers([pages[viewModel.currentDayIndex]], direction: .forward, animated: true, completion: nil)
		setHandlers()
    }

	private func setHandlers() {
		
	}
    
}

extension MainPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        (onSwipeAction ?? {})()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        (onSwipeAction ?? {})()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        viewModel.selectedDayIndex = viewControllerIndex
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        viewModel.selectedDayIndex = viewControllerIndex
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return nil }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
    
}

extension MainPageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}
