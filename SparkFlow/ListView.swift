//
//  ListView.swift
//  SparkFlow
//
//  Created by 贾建辉 on 2024/1/2.
//

import SwiftUI

struct ListView: View {
    
    //MARK: - CoreData
    //1、从环境中拿到CoreData的ViewContext，用来读取数据库；它是中介，负责增删改查
    @Environment(\.managedObjectContext) var viewContext
    
    //2、自动向数据库发送请求，有变化时会立即返回新数据，将返回的结果赋值给FetchRequest
    @FetchRequest(
        //按时间升序排序
        sortDescriptors: [NSSortDescriptor(keyPath: \Entity.timeStamp, ascending: true)],
        animation: .default
    )
    
    //3、将返回的数据存在listd中
    var lists: FetchedResults<Entity>
    
    //MARK: - Sheet
    @State var showAddSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(lists) { item in
                    //解包可选数据类型
                    let uiImage: UIImage? = item.image != nil ? UIImage(data: item.image!) : nil

                    ListRowView(title: item.title ?? "",
                                content: item.content ?? "",
                                timeStamp: displayDate(item.timeStamp!),
                                collected: item.collected,
                                uiImage: uiImage
                    )
                    
                    .swipeActions {
                        Button(role: .destructive) {
                            viewContext.delete(item)
                            try? viewContext.save()
                        } label: {
                            Text("删除")
                        }
                        
                        Button {
                            collectedEntity(entity: item)
                        } label: {
                            Text(item.collected ? "取消收藏" : "收藏")
                        }
                        .tint(.orange)

                    }
                }
            }
            
            .navigationTitle("列表")
            .toolbar {
                Button {
                    showAddSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }

            }
            .sheet(isPresented: $showAddSheet) {
                AddSheetView()
            }
        }
    }
    
    //MARK: - CoreData函数
    func deleteEntity(entity: FetchedResults<Entity>.Element) {
        viewContext.delete(entity)
        try? viewContext.save()
    }
    func collectedEntity(entity: FetchedResults<Entity>.Element) {
        entity.collected.toggle()
        try? viewContext.save()
    }
    
    //MARK: - 时间相关函数
    //时间格式化
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "zh_Hans")
        formatter.setLocalizedDateFormatFromTemplate("YYYYMMMMdd")
        
        return formatter
    }()
    
    //将Date转换为String
    func displayDate(_ date: Date) -> String {
        dateFormatter.string(from: date)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
