//
//  MainPresenter.swift
//  RSSReader
//
//  Created by Neskin Ivan on 09.12.2020.
//  Copyright © 2020 Neskin Ivan. All rights reserved.
//

import Foundation

class MainPresenter: IMainPresenter {
    
    private var view:IMainView?
    private var networkManager = NetworkManager()
    private var parseService = ParseService()
    private var dataItem: [Item] = []
    
    init(view: IMainView) {
        self.view = view
    }
    
    func getData() {
        networkManager.parseFeed(url: "https://lenta.ru/rss/articles") { [weak self] (data) in
            guard let self = self else { return }
            if  data == data {
                self.parseService.startParse(data: data)
            } else {
                print("error")
            }
        }
        returnItemsForParse()
    }
    
    func returnItemsForParse() {
        DispatchQueue.main.async {
            self.parseService.completion = { [weak self] items in
                guard let self = self else { return }
                self.dataItem = items
                self.view?.reloadDataInTable()
            }
        }
    }
    
    func getItems() -> [Item] {
        return dataItem
    }
    
    func dataCount() -> Int {
        return dataItem.count
    }
    
    
    func monoEffect() {
        addEffect(filterType: .Mono)
        self.view?.reloadDataInTable()
    }
    
    func chromeEffect() {
        addEffect(filterType: .Chrome)
        self.view?.reloadDataInTable()
    }
    
    private func addEffect(filterType: FilterType) -> [Item] {
        DispatchQueue.main.async {
            let effectScaleImage = self.dataItem.map { imageInput -> Item in
                let imageItemEffect = Item(title: imageInput.title, image: imageInput.image?.addFilter(filter: filterType))
                return imageItemEffect
            }
            self.dataItem = effectScaleImage
        }
        return dataItem
    }
    
    
    
}
