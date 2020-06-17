//
//  AnimatedZoomInTransition.swift
//  NextapTask
//

import UIKit

class AnimatedZoomInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
      self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let snapshot = toViewController.view.snapshotView(afterScreenUpdates: true) else {
                return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        let calculatedHeight = (originFrame.width * UIScreen.main.bounds.height) / UIScreen.main.bounds.width
        snapshot.frame = CGRect(x: originFrame.origin.x,
                                y: originFrame.origin.y - ((calculatedHeight - originFrame.height) / 2),
                                width: originFrame.width,
                                height: calculatedHeight)
        snapshot.layer.cornerRadius = StoryCollectionViewCell.UIProperties.imageCornerRadius
        snapshot.layer.masksToBounds = true
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshot)
        toViewController.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            snapshot.frame = finalFrame
            snapshot.layer.cornerRadius = 0
        }, completion: { _ in
            toViewController.view.isHidden = false
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
}
