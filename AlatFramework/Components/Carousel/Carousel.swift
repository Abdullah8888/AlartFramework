//
//  Carousel.swift
//  AlatFramework
//
//  Created by Adjogbe  Tejiri on 05/02/2023.
//
import Foundation

public class Carousel: iCarousel {
    
    @IBInspectable public var spacing: CGFloat = 0
    
    public var pageControl: UIPageControl?
    
    public var carouselType: iCarouselType = .linear {
        didSet {
            type = carouselType
            reloadData()
        }
    }
    public var items: [UIView] = [] {
        didSet {
            reloadData()
        }
    }
    
    public override func awakeFromNib() {
        setup()
    }

    func setup() {
        delegate = self
        dataSource = self
        bounces = false
        isPagingEnabled = true
    }
}

extension Carousel: iCarouselDelegate {
    
    public func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        pageControl?.currentPage = carousel.currentItemIndex
        switchBG(carousel)
    }
    
    
    public func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        pageControl?.numberOfPages = items.count
        switch option {
        case .spacing:
            return spacing > 0 ? spacing : value
        case .wrap:
            return 0
        default:
            return value
        }
    }
    
    public func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
        bounds.width
    }
    
    public func carousel(_ carousel: iCarousel, itemTransformForOffset offset: CGFloat, baseTransform transform: CATransform3D) -> CATransform3D {
        let centerItemZoom: CGFloat = 1.2
        let centerItemSpacing: CGFloat = 1.23
        let absClampedOffset = min(1.0, abs(offset))
        let clampedOffset = min(1.0, max(-1.0, offset))
        let scaleFactor = 1.0 + absClampedOffset * (1.0/centerItemZoom - 1.0)
        let newOffset = (scaleFactor * offset + scaleFactor * (centerItemSpacing - 1.0) * clampedOffset) * carousel.itemWidth * spacing
    
        var newTransform = transform
        if carousel.isVertical {
            newTransform = CATransform3DTranslate(newTransform, 0.0, newOffset, -absClampedOffset)
        } else {
            newTransform = CATransform3DTranslate(newTransform, newOffset, 0.0, -absClampedOffset)
        }
        
        newTransform = CATransform3DScale(newTransform, scaleFactor, scaleFactor, 1.0)
        return newTransform
   }
    
    func switchBG(_ carousel: iCarousel) {
        let centerIndex = carousel.currentItemIndex
        for index in 0..<carousel.numberOfItems {
            let itemView = carousel.itemView(at: index) as? AccountCard
            guard let view = itemView else { return }
            if index == centerIndex {
                view.switchBG()
            } else {
                view.switchBG(false)
            }
        }
    }
    
}

extension Carousel: iCarouselDataSource {
    public func numberOfItems(in carousel: iCarousel) -> Int {
        return items.count
    }
    
    public func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        items[index].frame = bounds
        items[index].widthAnchor.constraint(equalToConstant: bounds.width).isActive = true
        return items[index]
    }
}
