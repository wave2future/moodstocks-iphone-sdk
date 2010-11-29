# Moodstocks iPhone SDK

## Overview

Moodstocks iPhone SDK enables you to integrate image recognition into your iPhone mobile applications in seconds. It has been built to work on **iOS SDK 3.0 and higher**.

Basically it wraps the native image picker component, and adds some magic like encoding, querying, and parsing.
And you get a cool scanning effect for free!

## Setup

To integrate Moodstocks iPhone SDK into your application:

*   Drag `MoodstocksSDK.h` and `libMoodstocksSDK.a` from the `library/` directory into your Xcode project
*   On your Xcode project, expand the _Targets_ section and double-click your application's target
*   Click on the _General_ tab and add the following frameworks into the _Linked Libraries_ section:
	*   `CFNetwork`
	*   `SystemConfiguration`
	*   `MobileCoreServices`
	*   `CoreGraphics`
	*   `QuartzCore`
	*   `libz.1.2.3`
*   Click on the _Build_ tab, choose _All Configurations_ and add `-ObjC -all_load` for the _Other Linker Flags_ setting

You'll find an example application into `sample/DemoApp` which is properly configured.

## Using the SDK

Before you start using the SDK, you must first [register for an account](http://api.moodstocks.com/signup)
on [Moodstocks API](http://www.moodstocks.com/visual-search-as-a-service/), create an access key and import reference images
to be recognized.

Then, the SDK is pretty similar to the iOS `UIImagePickerController`:

*   Initialize an `MImagePickerController` with your API key and secret pair
*   Present it modally 
*   Implement the `MImagePickerControllerDelegate` protocol:
	*   `imagePickerController:didFinishQueryingWithInfo:`: this method is called when the image recognition has completed.
	     It returns a dictionary that includes the `status` (`ok` or `error`), the `message` (useful when an error occurs) and the
	     list of `matches` that refer to the item IDs you've imported into Moodstocks API.
	     This list is empty in case of no match found.
	*   `imagePickerControllerDidCancel:`: this method is called when the end user decides to cancel the current image image picker

Fore more details, please refer to the `sample/DemoApp` example application that fully illustrates how to use the SDK.

## Contact us

For more details feel free to join us on our [support chat](http://moodstocks.campfirenow.com/2416e), or contact us by email at
<a href="m&#x61;&#x69;l&#116;&#111;:&#x63;&#x6F;&#110;&#x74;&#097;&#099;&#x74;&#064;&#109;&#x6F;&#x6F;&#x64;&#115;&#x74;&#111;&#099;&#x6B;s&#x2E;&#099;&#x6F;&#109;">&#x63;&#x6F;&#110;&#x74;&#097;&#099;&#x74;&#064;&#109;&#x6F;&#x6F;&#x64;&#115;&#x74;&#111;&#099;&#x6B;s&#x2E;&#099;&#x6F;&#109;</a>.

## Copyright

Copyright (c) 2010 Moodstocks SAS
