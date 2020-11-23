![element](https://github.com/Element1/element-ios-face-sdk-local-example/raw/master/images/element.png "element")

## Element iOS Face SDK

The Element Face iOS SDK is an API to create the biometrics models that can be used to authenticate users.

## Version support

The Element Face iOS SDK supports iOS 10 and above.

## Prerequisites

### Element Dashboard Account
An account is required to access the Element Dashboard.

### Framework
The Element Face SDK is available on the Element Dashboard, under Account -> SDK -> SDK Files.
For more information, please refer to *iOS Face SDK Integration.pdf*.

Note that the Framework was not built with Bitcode enabled so you may have to disable Bitcode for your app in order to link against the Element SDK.  To do that, click on your project in Xcode then go to the "Build Settings" tab and search for *Enable Bitcode* and set it to *No*.

![bitcode_off](https://github.com/Element1/element-ios-face-sdk-local-example/raw/master/images/bitcode_off.png "bitcode_off")

### Register your application's Bundle Identifier (App Id) to Element and obtain the Encrypted Access Key (EAK)
The Element Face SDK requires the Encrypted Access Key (EAK) file. The EAK carries encrypted information required to configure the SDK. The EAK is available on Element Dashboard, under Account -> SDK.
For more information, please refer to *iOS Face SDK Integration.pdf*.

## Using the demo application

A demo application that uses the SDK is in the *Example* folder.

Please download the Element SDK / bundles and copy them in the Frameworks directory (element-ios-face-sdk-local-example/Example/demo/Frameworks) of the demo (this repository doesn't include the actual SDK data):

![framework](https://github.com/Element1/element-ios-face-sdk-local-example/raw/master/images/framework_location.png "framework")

Once you have downloaded and put the Element SDK in the Frameworks directory, you can open face_demo_protected.xcodeproj using Xcode and edit the "Bundle Identifier" of the app to use your company prefix:

![bundle_identifier](https://github.com/Element1/element-ios-face-sdk-local-example/raw/master/images/bundle_identifier.png "bundle_identifier")

The last step is to edit the AppDelegateProtected.swift file and replace YOUR_EAK with your EAK.

To run the demo app, click on the arrow on the top left:

![run](https://github.com/Element1/element-ios-face-sdk-local-example/raw/master/images/run.png "run")

- Note that the XCode project is set to "Automatically manage signing" so you will need to be signed into your Apple developer account in order to run the demo app on your phone (see https://developer.apple.com/library/content/qa/qa1814/_index.html).

## Documentation

More documentation is available on the Element Dashboard.
