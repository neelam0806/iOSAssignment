//
//  NetworkingManager.swift
//  iOSAssignment
//
//  Created by Neelam Gupta on 01/02/20.
//  Copyright © 2020 Neelam Gupta. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NetworkingManager: ObservableObject{
    var didChange = PassthroughSubject<NetworkingManager, Never>()
    @Published var jsonData = JSONData(title: "", rows: []){
        didSet {
            didChange.send(self)
        }
    }
    init() {
            guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else { return }
            
            URLSession.shared.dataTask(with: url){ (data, _, _) in
                guard let data = data else { return }
                let str = String(decoding: data, as: UTF8.self)
                let str1 = str.replacingOccurrences(of: "\n", with: "")
                if let data = str1.replacingOccurrences(of: "\t", with: "").data(using: String.Encoding.utf8) {
                    do {
                       let a = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]
                        print("check \(String(describing: a))")
                        let jsonList = try! JSONDecoder().decode(JSONData.self, from: data)
                                   
                                   DispatchQueue.main.async {
                                    self.jsonData.title = jsonList.title
                                    
                                    for var rowData in jsonList.rows! {
                                        
                                        rowData.title = self.nullToNil(value: rowData.title as AnyObject?) as? String
                                        rowData.description = self.nullToNil(value: rowData.description as AnyObject?) as? String
                                        rowData.imageHref = self.nullToNil(value: rowData.imageHref as AnyObject?) as? String
                                        if(rowData.description == nil){
                                            rowData.description = ""
                                        }
                                        if(rowData.imageHref == nil){
                                            rowData.imageHref = ""
                                        }
                                        if(rowData.title == nil){
                                            
                                        }else{
                                            self.jsonData.rows?.append(rowData)
                                        }
                                    }
                                   }
                    } catch {
                       print("ERROR \(error.localizedDescription)")
                    }
                }
                
            }.resume()
        
        }
        
        func nullToNil(value : AnyObject?) -> AnyObject? {
            if value is NSNull {
                return nil
            } else {
                return value
            }
        }
        
    }
