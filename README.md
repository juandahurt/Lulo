<p align="center">
 <img src="https://user-images.githubusercontent.com/26754335/216785839-264d87cb-dfd6-4082-b8c1-0131f2f0c695.svg" width="20%" alt="RxSwift Logo" />
</p>

This is a just a little web image downloader with the name of a fruit which is pretty common in Colombia. Nothing really complicated.

## How to use it

The easiest way to download an image is to create a downloadble image by using the `Lulo` builder.

```swift
let url = URL(string: "foo.com")!
let downloadbleImage = Lulo.image(from: url)
    .set(to: anImageView)

downloadbleImage.download() // starts the download
```

You can also add callbacks to react to certain changes

```swift
let url = URL(string: "foo.com")!
Lulo.image(from: url)
    .onComplete { error in
        // it gets called when the download finishes
        if error {
            print(error)
        }
    }
    .onProgress { percentage in
        // it gets called to notify the download progress
        // the `percentage` param is a Double from 0 to 1
    }
    .download()
```

That's pretty much it xd