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
    var onNewSwipeAction: ((Int) -> ())?
    
    private var currentIndex: Int = 0
    private var nextIndex: Int = 0
    
    lazy var changeDateTimeStringToHhMm: ((String) -> (String)) = { [weak self] dateTime in
        return self?.viewModel.getHhMmFormattedDateString(from: dateTime) ?? ""
    }
    
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
        let myScheduleViewController = ScheduleViewController(dayAppointments: viewModel.weekAppointments[weekdayIndex], viewModel: viewModel)
        myScheduleViewController.changeDateTimeStringToHhMm = changeDateTimeStringToHhMm
        return myScheduleViewController
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

// MARK: - UIPageViewControllerDataSource
extension MainPageViewController: UIPageViewControllerDataSource {
    
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
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
}

// MARK: - UIPageViewControllerDelegate
extension MainPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, finished else {
            return
        }
        viewModel.selectedDayIndex = currentIndex
        onSwipeAction?()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        currentIndex = pages.firstIndex(of: pendingViewControllers.first!)!
    }
}
