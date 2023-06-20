//
//  ServiceTagLabelsView.swift
//  Food-delivery-app
//
//  Created by Елена on 16.06.2023.
//

import UIKit
import SnapKit

class ServiceTagLabelsView: UIView {
    
    private enum Metrics {
        static let tagHeight: CGFloat = 30
        static let tagPadding: CGFloat = 16
        static let tagSpacingX: CGFloat = 8
        static let tagSpacingY: CGFloat = 8
    }
    
    //- MARK: Public properties
    
    var services: [ServiceModel] = [] {
        didSet {
            addTagLabels()
        }
    }
    
    var intrinsicHeight: CGFloat = 0
    
    var selectedServiceTagIds: [UUID]?
    var onServiceTagTapped: ((UUID) -> ())?
    
    
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
            newLabel.font = R.font.redHatDisplaySemiBold(size: 12)
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
            
            label.isUserInteractionEnabled = true
            let gestureRecognizer = ServiceTapGesture(target: self, action: #selector(serviceTagPressed(_:)))
            gestureRecognizer.serviceId = tag.id
            label.addGestureRecognizer(gestureRecognizer)
            if selectedServiceTagIds?.contains(tag.id) ?? false {
                label.backgroundColor = R.color.transparentWhite()
            }
        }
        
    }
    
    @objc private func serviceTagPressed(_ serviceTag: ServiceTapGesture) {
        (onServiceTagTapped ?? { _ in })(serviceTag.serviceId)
        if serviceTag.view?.backgroundColor == R.color.white()! {
            serviceTag.view?.backgroundColor = R.color.transparentWhite()
        }
        else {
            serviceTag.view?.backgroundColor = R.color.white()
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

final class ServiceTapGesture: UITapGestureRecognizer {
    var serviceId = UUID()
}
