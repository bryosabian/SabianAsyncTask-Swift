//
//  SabianAsyncTask.swift
//
//  Created by Jared Leto (Sabian) on 20/07/2021.
//  Copyright © 2021 Jared Leto. All rights reserved.
//

import Foundation

class SabianAsyncTask<T> {
    
    private var ioDispatcher : DispatchQueue {
        get {
            return DispatchQueue.global(qos: .background)
        }
    }
    
   private var defaultDispatcher : DispatchQueue{
        get {
            return DispatchQueue.main
        }
    }
    
    
    func execute(_ action :  @escaping () throws ->  T, onBefore : (() -> Void)? = nil,  onComplete :  ((T) -> Void)? = nil, onError : ((Error) -> Void)? = nil){
        
        onBefore?()
        
        var throwable: Error? = nil
        var retuns : T!
        
        let group = DispatchGroup()
        group.enter()
        
        ioDispatcher.async {
            do{
            retuns = try action()
            }catch {
                throwable = error
            }
            group.leave()
        }
        
        group.notify(queue: defaultDispatcher){
            
            if throwable != nil {
                onError?(throwable!)
            }else{
                onComplete?(retuns)
            }
        }
        
    }
    
}
