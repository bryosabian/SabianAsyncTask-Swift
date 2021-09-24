# SabianAsyncTask-Swift-IOS
This a threading wrapper for handling background tasks in iOS by making use of Swift Threading Libraries. This is inspired by my Android version of the same called [SabianAsyncTask](https://github.com/bryosabian/SabianAsyncTask)

How to use

```swift
enum MyError: Error {
    case runtimeError(String)
}

let task = SabianAsyncTask<Int>()

task.execute({
    //Do long running task here
    let amounts = [10,20,30]
    let sum = amounts.reduce(0, { x, y in
        x + y
    })
    if sum < 50 {
        throw MyError.runtimeError("Amounts must be greater or equal to 50")
    }
    return sum
}, onBefore: {
    //Do something on the main thread before the task runs e.g Show progress
    print("Task has begun")
},
onComplete: {  result in
    //Do some work on the main thread after the background task completes
    print(String(format: "Task has completed with result %@", result))
},
onError: { error in
    //Do some work on the main thread after the background task fails or throws an exception
    print(String(format: "Task has failed with result %@", error.localizedDescription))
})
               
```


               
