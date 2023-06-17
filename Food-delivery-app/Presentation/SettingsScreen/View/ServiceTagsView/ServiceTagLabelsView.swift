//
//  ServiceTagLabelsView.swift
//  Food-delivery-app
//
//  Created by Елена on 16.06.2023.
//

import UIKit
import SnapKit

class ServiceTagLabelsView: UIView {
    //- MARK: Public properties
    
    private enum Metrics {
        static let tagHeight: CGFloat = 30
        static let tagPadding: CGFloat = 16
        static let tagSpacingX: CGFloat = 8
        static let tagSpacingY: CGFloat = 8
    }
    
    var services: [Service] = [] {
        didSet {
            addTagLabels()
        }
    }
    
    var intrinsicHeight: CGFloat = 0
    
    
    //- MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    //- MARK: Override methods
    
    override var intrinsicContentSize: CGSize {
        var view = super.intrinsicContentSize
        view.height = intrinsicHeight
        return view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        displayTagLabels()
    }
    
    
    //- MARK: Public methods
    
    func addTagLabels() -> Void {
        while self.subviews.count > services.count {
            self.subviews[0].removeFromSuperview()
        }
        
        while self.subviews.count < services.count {
            let newLabel = UILabel()
            let rightLines = UIImageView(image: R.image.rightLines())
            let leftLines = UIImageView(image: R.image.leftLines())
            
            newLabel.textColor = R.color.vinous()
            newLabel.textAlignment = .center
            newLabel.backgroundColor = R.color.white()
            newLabel.layer.masksToBounds = true
            newLabel.layer.cornerRadius = 13
            
            newLabel.addSubview(rightLines)
            newLabel.addSubview(leftLines)
            self.addSubview(newLabel)
            
            rightLines.snp.makeConstraints { make in
                make.trailing.top.equalToSuperview()
            }
            
            leftLines.snp.makeConstraints { make in
                make.bottom.leading.equalToSuperview()
            }
        }
        
        for (tag, v) in zip(services, self.subviews) {
            guard let label = v as? UILabel else {
                fatalError("non-UILabel subview found!")
            }
            
            label.text = tag.name
            label.frame.size.width = label.intrinsicContentSize.width + Metrics.tagPadding
            label.frame.size.height = Metrics.tagHeight
        }
        
    }
    
    func displayTagLabels() {
        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0
        
        self.subviews.forEach { v in
            
            guard let label = v as? UILabel else {
                fatalError("non-UILabel subview found!")
            }
            
            if currentOriginX + label.frame.width > bounds.width {
                currentOriginX = 0
                currentOriginY += Metrics.tagHeight + Metrics.tagSpacingY
            }
            
            label.frame.origin.x = currentOriginX
            label.frame.origin.y = currentOriginY
            
            currentOriginX += label.frame.width + Metrics.tagSpacingX
            
        }
        
        intrinsicHeight = currentOriginY + Metrics.tagHeight
        invalidateIntrinsicContentSize()
    }
}