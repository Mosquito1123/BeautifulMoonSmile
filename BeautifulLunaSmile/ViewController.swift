//
//  ViewController.swift
//  BeautifulLunaSmile
//
//  Created by Mosquito1123 on 13/07/2019.
//  Copyright © 2019 Cranberry. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var model: LunarPhaseModel!
    
    private var shouldPresentAlert: Bool = true
    private var loadingObservation: NSKeyValueObservation? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.model = LunarPhaseModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private lazy var dataSource: PhasesDataSource = {
        return PhasesDataSource(model: self.model)
    }()
    
    private lazy var headerView: LunarHeaderView = {
        let nib = Bundle.main.loadNibNamed("LunarHeaderView", owner: self, options: nil)
        guard let headerView = nib?.first as? LunarHeaderView else {
            return LunarHeaderView()
//            fatalError("Could not load LunarHeaderView from nib")
        }
        
        return headerView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        let action = #selector(ViewController.handleRefresh(_:))
        control.addTarget(self, action: action, for: UIControl.Event.valueChanged)
        control.backgroundColor = UIColor.clear
        control.tintColor = UIColor.white
        
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.isPagingEnabled = true
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.hexColor("232526").cgColor, UIColor.hexColor("414345").cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
        
        self.tableView.backgroundColor = UIColor.brown
        self.tableView.separatorColor = UIColor.lightGray
        
        self.tableView.separatorStyle = .none
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
        }
        
        self.dataSource.configure(using: tableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(modelDidUpdate(_:)), name: .didUpdateMoon, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveError(_:)), name: .didReceiveLunarModelError, object: nil)
        
        loadingObservation = self.model.observe(\.loading) { (observed, change) in
            let visible = self.model.loading
            let deadline: DispatchTime = visible ? .now() : .now() + .seconds(1)
            
            DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = visible
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.tableHeaderView = self.headerView
        if #available(iOS 9.0, *) {
            self.tableView.tableHeaderView?.frame = view.layoutMarginsGuide.layoutFrame
        } else {
            // Fallback on earlier versions
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Update Handlers
    
    @objc internal func handleRefresh(_ sender: AnyObject) {
        model.refresh { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc internal func didReceiveError(_ notification: Notification) -> Void {
        let error = notification.object
        
        switch error {
        case let localizedError as LocalizedError:
            showAlert("Error", localizedError.localizedDescription)
        default:
            showAlert("Error", error.debugDescription)
        }
    }
    
    @objc internal func modelDidUpdate(_ notification: Notification) -> Void {
        self.updateLunarViewModel()
    }
    
    private func updateLunarViewModel() -> Void {
        switch model.currentMoon {
        case .success(let moon):
            self.headerView.viewModel = LunarViewModel(moon: moon)
        case .failure:
            print("error updating view model, no data")
        }
    }
    
    private func showAlert(_ title: String, _ message: String) {
        DispatchQueue.main.async {
            if self.shouldPresentAlert {
                self.shouldPresentAlert = false
                
                let handler: (UIAlertAction) -> Void = { [weak self] action in
                    self?.dismiss(animated: true)
                    self?.shouldPresentAlert = true
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: handler)
                
                alertController.addAction(action)
                self.present(alertController, animated: true)
            }
        }
    }
}
