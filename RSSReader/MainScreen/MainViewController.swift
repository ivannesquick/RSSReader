//
//  MainViewController.swift
//  RSSReader
//
//  Created by Neskin Ivan on 09.12.2020.
//  Copyright © 2020 Neskin Ivan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, IMainView {
    var newsCount = 20
    
    fileprivate lazy var mainPresenter:IMainPresenter = {
        let presenter = MainPresenter(view: self)
        return presenter
    }()
    
    fileprivate let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 255, green: 96, blue: 96)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    fileprivate var tableView:UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 10
        return table
    }()
    
    fileprivate let activityIndicatorLoad:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    fileprivate let indicatoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor.rgb(red: 170, green: 213, blue: 244)
        view.isHidden = true
        return view
    }()
    
    fileprivate let activityLabel: UILabel = {
       let label = UILabel()
        label.text = "Загрузка"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    fileprivate var monoEffectButton = UIButton.setupButton(title: "Mono", color: UIColor.rgb(red: 89, green: 118, blue: 229))
    fileprivate var chromeEffectButton = UIButton.setupButton(title: "Chrome", color: UIColor.rgb(red: 89, green: 118, blue: 229))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupConstraint()
        addTarget()
        beginLoading()
    }
    
    private func addTarget() {
        monoEffectButton.addTarget(self, action: #selector(changeMonoEffect), for: .touchUpInside)
        chromeEffectButton.addTarget(self, action: #selector(addChrome), for: .touchUpInside)
    }
    
    @objc private func changeMonoEffect() {
        mainPresenter.monoEffect()
    }
    
    @objc private func addChrome() {
        mainPresenter.chromeEffect()
    }
    
    private func setupConstraint() {
        view.addSubview(containerView)
        view.addSubview(tableView)
        
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -5).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [monoEffectButton, chromeEffectButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
        stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5).isActive = true
        
        tableView.addSubview(indicatoView)
        
        indicatoView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        indicatoView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        indicatoView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        indicatoView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        indicatoView.addSubview(activityIndicatorLoad)
        indicatoView.addSubview(activityLabel)
        
        activityIndicatorLoad.centerXAnchor.constraint(equalTo: indicatoView.centerXAnchor).isActive = true
        activityIndicatorLoad.centerYAnchor.constraint(equalTo: indicatoView.centerYAnchor).isActive = true
        activityIndicatorLoad.widthAnchor.constraint(equalToConstant: 10).isActive = true
        activityIndicatorLoad.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        activityLabel.centerXAnchor.constraint(equalTo: indicatoView.centerXAnchor).isActive = true
        activityLabel.bottomAnchor.constraint(equalTo: indicatoView.bottomAnchor, constant: -5).isActive = true
        
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Lenta"
        navigationController?.navigationBar.barTintColor = UIColor.systemBlue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        
        navigationController?.navigationBar.tintColor = .white
    }
    
}
// MARK: - DataSource and Delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainPresenter.getItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.cellID, for: indexPath) as! MainCell
        let items = mainPresenter.getItems()
        let element = items[indexPath.row]
        cell.configureWith(item: element)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = mainPresenter.getItems().count
            if indexPath.row == (count - 1) {
                let spinner = UIActivityIndicatorView(style: .large)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(144))
                tableView.tableFooterView = spinner
                tableView.tableFooterView?.isHidden = false
                beginLoading()
            }
    }
    
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MainCell.cellID)
        let nib  = UINib(nibName: "MainCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MainCell.cellID)
    }
    
    func reloadDataInTable() {
        DispatchQueue.main.async {
            self.setupTable()
            self.tableView.reloadData()
            self.stopAnimating()
        }
    }
}

extension MainViewController {
    func beginLoading() {
        startActivity()
        mainPresenter.getData()
    }
}

// MARK: - Setup activity indicator
extension MainViewController {
    fileprivate func startActivity() {
        indicatoView.isHidden = false
        activityIndicatorLoad.startAnimating()
    }
    
    fileprivate func stopAnimating() {
        activityIndicatorLoad.stopAnimating()
        indicatoView.isHidden = true
        activityIndicatorLoad.isHidden = true
    }
}
