# SabianAsyncTask-Swift-IOS-
This a threading wrapper for handling background tasks in iOS by making use of Swift Threading Libraries. This is inspired by my Android version of the same called SabianAsyncTask [a link](https://github.com/bryosabian/SabianAsyncTask)

How to use

```swift
enum MyError: Error {
    case runtimeError(String)
}

let task = SabianAsyncTask<Int>()

task.execute({
    let amounts = [10,20,30]
    let sum = amounts.reduce(0, { x, y in
        x + y
    })
    if sum < 50 {
        throw MyError.runtimeError("Amount must be greater or equal to 50")
    }
    return sum
}, onBefore: {
    print("Task has begun")
},
onComplete: {  result in
    print(String(format: "Task has completed with result %@", result))
},
onError: { error in
    print(String(format: "Task has failed with result %@", error.localizedDescription))
})
               
```


               
