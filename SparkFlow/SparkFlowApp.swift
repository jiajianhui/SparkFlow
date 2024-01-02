//
//  SparkFlowApp.swift
//  SparkFlow
//
//  Created by 贾建辉 on 2024/1/2.
//

import SwiftUI

@main
struct SparkFlowApp: App {
    
    //1、创建CoreData的实例
    let ListDataManager = ListData.shared
    
    
    var body: some Scene {
        WindowGroup {
            ListView()
            //2、将实例放入该视图环境
            .environment(\.managedObjectContext, ListDataManager.container.viewContext)
        }
    }
}
