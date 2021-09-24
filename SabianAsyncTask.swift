//
//  SabianAsyncTask.swift
//
//  Created by Jared Leto (Sabian) on 20/07/2021.
//  Copyright © 2021 Jared Leto.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this program and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the program, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be included
//  in all copies or substantial portions of the program.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  PROGRAM OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
