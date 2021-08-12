//
//  ViewController.swift
//  Example
//
//  Created by Yuya Oka on 2021/08/09.
//

import MultipleImageView
import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var multipleImageView: MultipleImageView! {
        didSet {
            multipleImageView.layer.cornerRadius = 20
            multipleImageView.layer.masksToBounds = true
            multipleImageView.delegate = self
        }
    }

    // swiftlint:disable line_length
    private lazy var sources: [MultipleImageView.Source] = [
        .uiimage(UIImage(systemName: "a.book.closed")!),
        .url(URL(string: "https://1.bp.blogspot.com/-bJ0oTWgJWrk/XnoiWQBOYYI/AAAAAAABX5Y/OyhdHjIA5_0737fyRKpwEpy34x32s_G9wCNcBGAsYHQ/s450/olympics_tokyo_2021_line.png")!),
        .url(URL(string: "https://2.bp.blogspot.com/--yCZ9NOGK0Q/W1a5NUMb33I/AAAAAAABNko/KdbkLvHkltYeMpCG-TWtmStiAbT1p-MCACLcBGAs/s800/sushi_oke_nigiri.png")!),
        .custom { imageView in
            DispatchQueue.global().async {
                guard let url = URL(string: "https://3.bp.blogspot.com/-WiNPt0_l3lc/U0pTNIhcmUI/AAAAAAAAfF4/BW1m-kFqMzI/s400/fujisan_shikaku.png"),
                      let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    ]
    // swiftlint:enable line_length

    override func viewDidLoad() {
        super.viewDidLoad()
        multipleImageView.sources = sources
        multipleImageView.reloadData()
    }
}

// MARK: - MultipleImageViewDelegate
extension ViewController: MultipleImageViewDelegate {

    func multipleImageViewShouldGetImage(_ imageView: UIImageView, sourceForURL url: URL, index: Int) {
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
            task.resume()
        }
    }

    func multipleImageViewDidSelect(_ imageView: UIImageView, index: Int) {
        print("Tapped index: \(index)")
    }
}
