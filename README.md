# Travelog

A Travel and Log application

## How it works?
* The user can search for any country
* The details of the country shows very limited information
* The user can add any number of reviews/notes to the country
* The user can also express their interest in this country by taping on the interest section
* The user can check all the countries with at least one review or any interest from the bookmarks page.
* The contents of the bookmarks page can be filtered with respect to user preferences.

## Frameworks used

* Foundation
* UIKit
* Combine
* SwiftUI

## 3rd Party Libraries/ Modules used
The Libraries are added using ***Swift Package Manager***
* [DeviceKit](https://github.com/devicekit/DeviceKit) to easily get device-related information
* [SDWebImage](https://github.com/SDWebImage/SDWebImage) to Asynchronous/Lazy loading of images from URLs

## Design Pattern Followed
MVVM-C, uses Model, View Model, View/ViewController & Coordinators
The design uses protocols to make sure that the design adheres to Dependency Injection.

## SwiftUI
It is only used to build the Onboarding screen. UIHostingViewController is used to make a bridge between SwiftUI and UIKit.

## Coordinators
The Maincoordinator is initialized from the scene delegate. The Basecoordinator has free() and save() methods to manage memory.

## Developer
**Chandrachudh K**

