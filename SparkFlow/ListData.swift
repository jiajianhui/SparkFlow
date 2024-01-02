//
//  ListData.swift
//  SparkFlow
//
//  Created by 贾建辉 on 2024/1/2.
//

import Foundation
import SwiftUI

//1、引入CoreData
import CoreData

struct ListData {
    //2、自身初始化
    static let shared = ListData()
    
    //3、新变量，支持本地和网络存储的数据容器
    let container: NSPersistentContainer
    
    //4、初始化container
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ListData")  //创建容器，名称必须为数据模型的名字
        
        //以下为模版代码
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _,_ in })
    }
}
