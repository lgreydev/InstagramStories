//
//  FirstViewController.swift
//  InstagramStories
//
//  Created by Sergey Lukaschuk on 29.09.2022.
//

import UIKit
import SwiftUI

class FirstViewController: UIViewController {

    private let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
    }
}

private extension FirstViewController {
    func setupButton() {
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Show Settings", for: .normal)
        button.backgroundColor = .systemIndigo
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc func didTapButton() {
        let vc = UIHostingController(rootView: StoryDisplay())

        vc.rootView.dismiss = {
            vc.dismiss(animated: true, completion: nil)
        }

        vc.rootView.present = {
            let secondViewController = SecondViewController()
            vc.show(secondViewController, sender: nil)
        }

        present(vc, animated: true, completion: nil)
    }
}
