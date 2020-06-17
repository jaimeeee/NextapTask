//
//  StoryCollectionViewCell.swift
//  NextapTask
//

import UIKit
import Kingfisher

class StoryCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = StoryCollectionViewCell.description()
    
    private var imageView = UIImageView()
    private var userLabel = UILabel()
    
    private enum UIProperties {
        static let imageCornerRadius: CGFloat = 6
        static let imageRatio: CGFloat = 16 / 9
        static let labelHeight: CGFloat = 24
        static let borderColor: CGColor = UIColor.black.withAlphaComponent(0.1).cgColor
        static let borderWidth: CGFloat = 1 / UIScreen.main.scale
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(userLabel)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width * UIProperties.imageRatio)
        userLabel.frame = CGRect(x: UIProperties.imageCornerRadius,
                                 y: imageView.frame.height,
                                 width: frame.width - (UIProperties.imageCornerRadius * 2),
                                 height: UIProperties.labelHeight)
    }
    
    private func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UIProperties.imageCornerRadius
        imageView.layer.borderColor = UIProperties.borderColor
        imageView.layer.borderWidth = UIProperties.borderWidth
        userLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    // MARK: Content
    
    func setupCell(with story: Story) {
        if let storyColor = story.color, let color = UIColor(hex: storyColor) {
            imageView.backgroundColor = color
        } else {
            imageView.backgroundColor = .systemBackground
        }
        imageView.kf.setImage(with: story.coverSrc)
        userLabel.text = story.user.displayName
    }
    
    // MARK: Static
    
    static func calculatedHeight(for width: CGFloat) -> CGFloat {
        return (width * UIProperties.imageRatio) + UIProperties.labelHeight
    }
    
}
