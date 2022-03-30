//
//  ContainerViewController.swift
//  SpotifyPreviewApp
//
//  Created by Valeriia Yevtushenko on 30.03.2022.
//

import UIKit

protocol ContainerViewControllerDelegate: AnyObject {
    var isMiniContainerViewHidden: Bool { get set }
    func setup(mainViewController: UIViewController, miniViewController: UIViewController)
}

class ContainerViewController: UIViewController {
    @IBOutlet private weak var mainContainerView: UIView!
    @IBOutlet private weak var miniContainerView: UIView!
    
    var mainViewController: UIViewController!
    var miniViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().barTintColor = .secondarySystemBackground
        setupMainContainer()
        setupMiniContainer()
    }
}

private extension ContainerViewController {
    func setupMainContainer() {
        mainViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(mainViewController)
        mainContainerView.addSubview(mainViewController.view)
        mainViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            mainViewController.view.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            mainViewController.view.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            mainViewController.view.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            mainViewController.view.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor)
        ])
    }
    
    func setupMiniContainer() {
        miniContainerView.isHidden = true
        miniViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(miniViewController)
        miniContainerView.addSubview(miniViewController.view)
        miniViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            miniViewController.view.leadingAnchor.constraint(equalTo: miniContainerView.leadingAnchor),
            miniViewController.view.trailingAnchor.constraint(equalTo: miniContainerView.trailingAnchor),
            miniViewController.view.topAnchor.constraint(equalTo: miniContainerView.topAnchor),
            miniViewController.view.bottomAnchor.constraint(equalTo: miniContainerView.bottomAnchor)
        ])
    }
}

extension ContainerViewController: ContainerViewControllerDelegate {
    var isMiniContainerViewHidden: Bool {
        get {
            return miniContainerView.isHidden
        }
        set {
            miniContainerView.isHidden = newValue
        }
    }
    
    func setup(mainViewController: UIViewController, miniViewController: UIViewController) {
        self.mainViewController = mainViewController
        self.miniViewController = miniViewController
    }
}
