//
//  ImageData.swift
//  SparkFlow
//
//  Created by 贾建辉 on 2024/1/3.
//

import Foundation

import SwiftUI
import PhotosUI

class ImageData: ObservableObject {
    
    //定义图片状态
    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }
    
    enum TransferError: Error {
        case impotFailed
    }
    
    //创建 SelectedImage 模型，处理图片 DataRepresentation 的数据，将其转换为 UIImage 或 NSImage
    struct SelectedImage: Transferable {
        let image: Image
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.impotFailed
                }
                
                let image = Image(uiImage: uiImage) //接收将上面得到的信息
                return SelectedImage(image: image)  //将转换后的数据return出去
            }
        }
    }
    
    //对外发布数据
    @Published private(set) var imageState: ImageState = .empty
    
    
    @Published var selectedImage: PhotosPickerItem? = nil {
        didSet {
            if let selectedImage {
                let progress = loadTransferable(form: selectedImage)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    //函数
    func loadTransferable(form photoPickerItem: PhotosPickerItem) -> Progress {
        return photoPickerItem.loadTransferable(type: SelectedImage.self) { result in
            DispatchQueue.main.async {
                guard photoPickerItem == self.selectedImage else {
                    print("图片加载失败")
                    return
                }
                
                switch result {
                    case .success(let selectedImage?):
                        self.imageState = .success(selectedImage.image)
                    case .success(nil):
                        self.imageState = .empty
                    case .failure(let error):
                        self.imageState = .failure(error)
                }
            }
        }
    }
    
    
}
