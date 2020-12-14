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
    private lazy var addEffect = AddEffectInImage()
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
    
    
    func changeBlackAndWhite() {
        let grayScaleImage = dataItem.map { grayImage -> Item in
            let grayImageItem = Item(title: grayImage.title, image: addEffect.convertToGrayScale(image: grayImage.image!))
            return grayImageItem
        }
        dataItem = grayScaleImage
        self.view?.reloadDataInTable()
    }
    
    func addBlurEffectInImage() {
        let blurScaleImage = dataItem.map { blurImage -> Item in
            let blurImageItem = Item(title: blurImage.title, image: addEffect.addBlurEffect(image: blurImage.image!))
            return blurImageItem
        }
        dataItem = blurScaleImage
        self.view?.reloadDataInTable()
    }
    
    
    
}
