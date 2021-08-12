//
//  MultipleImageView.swift
//
//
//  Created by Yuya Oka on 2021/08/09.
//

import UIKit

public protocol MultipleImageViewDelegate: AnyObject {

    func multipleImageViewShouldGetImage(_ imageView: UIImageView, sourceForURL url: URL, index: Int)
    func multipleImageViewDidSelect(_ imageView: UIImageView, index: Int)
}

@IBDesignable
public final class MultipleImageView: UIView {

    // MARK: - Properties
    public weak var delegate: MultipleImageViewDelegate?

    @IBInspectable
    public var placeholderImage: UIImage? {
        didSet {
            setPlaceholderImage()
        }
    }
    @IBInspectable
    public var spacing: CGFloat = 0 {
        didSet {
            topStackView.spacing = spacing
            leftStackView.spacing = spacing
            rightStackView.spacing = spacing
        }
    }

    public var sources: [Source] = []

    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topLeftImageView, bottomLeftImageView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        stackView.clipsToBounds = true
        return stackView
    }()
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topRightImageView, bottomRightImageView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        stackView.clipsToBounds = true
        return stackView
    }()
    private lazy var topLeftImageView: UIImageView = {
        let imageView = UIImageView(image: placeholderImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private lazy var topRightImageView: UIImageView = {
        let imageView = UIImageView(image: placeholderImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private lazy var bottomLeftImageView: UIImageView = {
        let imageView = UIImageView(image: placeholderImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private lazy var bottomRightImageView: UIImageView = {
        let imageView = UIImageView(image: placeholderImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    // MARK: - Initialize
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
}

// MARK: - Public method
public extension MultipleImageView {

    func reloadData() {
        setPlaceholderImage()
        // UIStackView
        leftStackView.isHidden = sources.isEmpty
        rightStackView.isHidden = sources.count < 2
        // UIImageView
        topLeftImageView.isHidden = sources.isEmpty
        topRightImageView.isHidden = sources.count < 2
        bottomLeftImageView.isHidden = sources.count != 4
        bottomRightImageView.isHidden = sources.count < 3
        sources.enumerated().forEach { index, source in
            guard let imageView = getImageView(from: index) else { return }
            switch source {
            case .uiimage(let image):
                imageView.image = image
            case .url(let url):
                delegate?.multipleImageViewShouldGetImage(imageView, sourceForURL: url, index: index)
            case .custom(let handler):
                handler(imageView)
            }
        }
    }
}

// MARK: - Source
public extension MultipleImageView {

    enum Source {
        case uiimage(UIImage)
        case url(URL)
        case custom((UIImageView) -> Void)
    }
}

// MARK: - Private method
private extension MultipleImageView {

    func initView() {
        backgroundColor = .clear
        // StackView
        addSubview(topStackView)
        NSLayoutConstraint(item: topStackView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: topStackView,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .left,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: topStackView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: topStackView,
                           attribute: .right,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .right,
                           multiplier: 1,
                           constant: 0).isActive = true
        // UITapGestureRecognizer
        let topLeftTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(onTapTopLeftGeture(_:)))
        topLeftImageView.addGestureRecognizer(topLeftTapGestureRecognizer)
        let topRightTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                  action: #selector(onTapTopRightGesture(_:)))
        topRightImageView.addGestureRecognizer(topRightTapGestureRecognizer)
        let bottomLeftTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                    action: #selector(onTapBottomLeftGesture(_:)))
        bottomLeftImageView.addGestureRecognizer(bottomLeftTapGestureRecognizer)
        let bottomRightTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                     action: #selector(onTapBottomRightGesture(_:)))
        bottomRightImageView.addGestureRecognizer(bottomRightTapGestureRecognizer)
    }

    func setPlaceholderImage() {
        topLeftImageView.image = placeholderImage
        topRightImageView.image = placeholderImage
        bottomLeftImageView.image = placeholderImage
        bottomRightImageView.image = placeholderImage
    }

    func getImageView(from index: Int) -> UIImageView? {
        switch (sources.count, index) {
        case (1, 0), (2, 0), (3, 0), (4, 0):
            return topLeftImageView
        case (2, 1), (3, 1), (4, 1):
            return topRightImageView
        case (4, 2):
            return bottomLeftImageView
        case (3, 2), (4, 3):
            return bottomRightImageView
        default:
            return nil
        }
    }
}

// MARK: - Selector target
private extension MultipleImageView {

    @objc func onTapTopLeftGeture(_ gesture: UITapGestureRecognizer) {
        delegate?.multipleImageViewDidSelect(topLeftImageView, index: 0)
    }

    @objc func onTapTopRightGesture(_ gesture: UITapGestureRecognizer) {
        delegate?.multipleImageViewDidSelect(topRightImageView, index: 1)
    }

    @objc func onTapBottomLeftGesture(_ gesture: UITapGestureRecognizer) {
        delegate?.multipleImageViewDidSelect(bottomLeftImageView, index: 2)
    }

    @objc func onTapBottomRightGesture(_ gesture: UITapGestureRecognizer) {
        delegate?.multipleImageViewDidSelect(bottomRightImageView, index: sources.count == 4 ? 3 : 2)
    }
}
