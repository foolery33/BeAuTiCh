//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle
  var string: string { .init(bundle: bundle, preferredLanguages: nil, locale: nil) }
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var info: info { .init(bundle: bundle) }
  var font: font { .init(bundle: bundle) }
  var file: file { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func string(bundle: Foundation.Bundle) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: nil)
  }
  func string(locale: Foundation.Locale) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: locale)
  }
  func string(preferredLanguages: [String], locale: Locale? = nil) -> string {
    .init(bundle: bundle, preferredLanguages: preferredLanguages, locale: locale)
  }
  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func info(bundle: Foundation.Bundle) -> info {
    .init(bundle: bundle)
  }
  func font(bundle: Foundation.Bundle) -> font {
    .init(bundle: bundle)
  }
  func file(bundle: Foundation.Bundle) -> file {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.font.validate()
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "en"
  }

  /// This `_R.string` struct is generated, and contains static references to 7 localization tables.
  struct string {
    let bundle: Foundation.Bundle
    let preferredLanguages: [String]?
    let locale: Locale?
    var errors: errors { .init(source: .init(bundle: bundle, tableName: "Errors", preferredLanguages: preferredLanguages, locale: locale)) }
    var informationSubcscribeSheetScreen: informationSubcscribeSheetScreen { .init(source: .init(bundle: bundle, tableName: "InformationSubcscribeSheetScreen", preferredLanguages: preferredLanguages, locale: locale)) }
    var loginScreen: loginScreen { .init(source: .init(bundle: bundle, tableName: "LoginScreen", preferredLanguages: preferredLanguages, locale: locale)) }
    var registerScreen: registerScreen { .init(source: .init(bundle: bundle, tableName: "RegisterScreen", preferredLanguages: preferredLanguages, locale: locale)) }
    var searchScreen: searchScreen { .init(source: .init(bundle: bundle, tableName: "SearchScreen", preferredLanguages: preferredLanguages, locale: locale)) }
    var settingsScreen: settingsScreen { .init(source: .init(bundle: bundle, tableName: "SettingsScreen", preferredLanguages: preferredLanguages, locale: locale)) }
    var startScreen: startScreen { .init(source: .init(bundle: bundle, tableName: "StartScreen", preferredLanguages: preferredLanguages, locale: locale)) }

    func errors(preferredLanguages: [String]) -> errors {
      .init(source: .init(bundle: bundle, tableName: "Errors", preferredLanguages: preferredLanguages, locale: locale))
    }
    func informationSubcscribeSheetScreen(preferredLanguages: [String]) -> informationSubcscribeSheetScreen {
      .init(source: .init(bundle: bundle, tableName: "InformationSubcscribeSheetScreen", preferredLanguages: preferredLanguages, locale: locale))
    }
    func loginScreen(preferredLanguages: [String]) -> loginScreen {
      .init(source: .init(bundle: bundle, tableName: "LoginScreen", preferredLanguages: preferredLanguages, locale: locale))
    }
    func registerScreen(preferredLanguages: [String]) -> registerScreen {
      .init(source: .init(bundle: bundle, tableName: "RegisterScreen", preferredLanguages: preferredLanguages, locale: locale))
    }
    func searchScreen(preferredLanguages: [String]) -> searchScreen {
      .init(source: .init(bundle: bundle, tableName: "SearchScreen", preferredLanguages: preferredLanguages, locale: locale))
    }
    func settingsScreen(preferredLanguages: [String]) -> settingsScreen {
      .init(source: .init(bundle: bundle, tableName: "SettingsScreen", preferredLanguages: preferredLanguages, locale: locale))
    }
    func startScreen(preferredLanguages: [String]) -> startScreen {
      .init(source: .init(bundle: bundle, tableName: "StartScreen", preferredLanguages: preferredLanguages, locale: locale))
    }


    /// This `_R.string.errors` struct is generated, and contains static references to 5 localization keys.
    struct errors {
      let source: RswiftResources.StringResource.Source

      /// en translation: Appointments loading error
      ///
      /// Key: appointments_loading_error
      ///
      /// Locales: en, ru
      var appointments_loading_error: RswiftResources.StringResource { .init(key: "appointments_loading_error", tableName: "Errors", source: source, developmentValue: "Appointments loading error", comment: nil) }

      /// en translation: Internal application error. Please contact developer
      ///
      /// Key: model_error
      ///
      /// Locales: en, ru
      var model_error: RswiftResources.StringResource { .init(key: "model_error", tableName: "Errors", source: source, developmentValue: "Internal application error. Please contact developer", comment: nil) }

      /// en translation: Ok
      ///
      /// Key: ok
      ///
      /// Locales: en, ru
      var ok: RswiftResources.StringResource { .init(key: "ok", tableName: "Errors", source: source, developmentValue: "Ok", comment: nil) }

      /// en translation: Some server error occured. Please try again later
      ///
      /// Key: server_error
      ///
      /// Locales: en, ru
      var server_error: RswiftResources.StringResource { .init(key: "server_error", tableName: "Errors", source: source, developmentValue: "Some server error occured. Please try again later", comment: nil) }

      /// en translation: Your authentication token is expired. Please login again
      ///
      /// Key: unauthorized
      ///
      /// Locales: en, ru
      var unauthorized: RswiftResources.StringResource { .init(key: "unauthorized", tableName: "Errors", source: source, developmentValue: "Your authentication token is expired. Please login again", comment: nil) }
    }

    /// This `_R.string.informationSubcscribeSheetScreen` struct is generated, and contains static references to 3 localization keys.
    struct informationSubcscribeSheetScreen {
      let source: RswiftResources.StringResource.Source

      /// en translation: Cancel subscription
      ///
      /// Key: cancel_subscription
      ///
      /// Locales: en, ru
      var cancel_subscription: RswiftResources.StringResource { .init(key: "cancel_subscription", tableName: "InformationSubcscribeSheetScreen", source: source, developmentValue: "Cancel subscription", comment: nil) }

      /// en translation: The subscription has been issued: 
      ///
      /// Key: start_date_subscribe
      ///
      /// Locales: en, ru
      var start_date_subscribe: RswiftResources.StringResource { .init(key: "start_date_subscribe", tableName: "InformationSubcscribeSheetScreen", source: source, developmentValue: "The subscription has been issued: ", comment: nil) }

      /// en translation: Subscription Information
      ///
      /// Key: title_screen
      ///
      /// Locales: en, ru
      var title_screen: RswiftResources.StringResource { .init(key: "title_screen", tableName: "InformationSubcscribeSheetScreen", source: source, developmentValue: "Subscription Information", comment: nil) }
    }

    /// This `_R.string.loginScreen` struct is generated, and contains static references to 5 localization keys.
    struct loginScreen {
      let source: RswiftResources.StringResource.Source

      /// en translation: Register
      ///
      /// Key: have_not_account
      ///
      /// Locales: en, ru
      var have_not_account: RswiftResources.StringResource { .init(key: "have_not_account", tableName: "LoginScreen", source: source, developmentValue: "Register", comment: nil) }

      /// en translation: Enter email
      ///
      /// Key: input_email
      ///
      /// Locales: en, ru
      var input_email: RswiftResources.StringResource { .init(key: "input_email", tableName: "LoginScreen", source: source, developmentValue: "Enter email", comment: nil) }

      /// en translation: Enter the password
      ///
      /// Key: input_password
      ///
      /// Locales: en, ru
      var input_password: RswiftResources.StringResource { .init(key: "input_password", tableName: "LoginScreen", source: source, developmentValue: "Enter the password", comment: nil) }

      /// en translation: Log in
      ///
      /// Key: login
      ///
      /// Locales: en, ru
      var login: RswiftResources.StringResource { .init(key: "login", tableName: "LoginScreen", source: source, developmentValue: "Log in", comment: nil) }

      /// en translation: Welcome back!
      ///
      /// Key: repeat_greeting
      ///
      /// Locales: en, ru
      var repeat_greeting: RswiftResources.StringResource { .init(key: "repeat_greeting", tableName: "LoginScreen", source: source, developmentValue: "Welcome back!", comment: nil) }
    }

    /// This `_R.string.registerScreen` struct is generated, and contains static references to 8 localization keys.
    struct registerScreen {
      let source: RswiftResources.StringResource.Source

      /// en translation: Welcome!
      ///
      /// Key: first_greeting
      ///
      /// Locales: en, ru
      var first_greeting: RswiftResources.StringResource { .init(key: "first_greeting", tableName: "RegisterScreen", source: source, developmentValue: "Welcome!", comment: nil) }

      /// en translation: I already have an account
      ///
      /// Key: have_account
      ///
      /// Locales: en, ru
      var have_account: RswiftResources.StringResource { .init(key: "have_account", tableName: "RegisterScreen", source: source, developmentValue: "I already have an account", comment: nil) }

      /// en translation: Enter email*
      ///
      /// Key: input_email
      ///
      /// Locales: en, ru
      var input_email: RswiftResources.StringResource { .init(key: "input_email", tableName: "RegisterScreen", source: source, developmentValue: "Enter email*", comment: nil) }

      /// en translation: Enter a name*
      ///
      /// Key: input_firstname
      ///
      /// Locales: en, ru
      var input_firstname: RswiftResources.StringResource { .init(key: "input_firstname", tableName: "RegisterScreen", source: source, developmentValue: "Enter a name*", comment: nil) }

      /// en translation: Enter your last name*
      ///
      /// Key: input_lastname
      ///
      /// Locales: en, ru
      var input_lastname: RswiftResources.StringResource { .init(key: "input_lastname", tableName: "RegisterScreen", source: source, developmentValue: "Enter your last name*", comment: nil) }

      /// en translation: Enter the password*
      ///
      /// Key: input_password
      ///
      /// Locales: en, ru
      var input_password: RswiftResources.StringResource { .init(key: "input_password", tableName: "RegisterScreen", source: source, developmentValue: "Enter the password*", comment: nil) }

      /// en translation: Repeat the password*
      ///
      /// Key: input_repeat_password
      ///
      /// Locales: en, ru
      var input_repeat_password: RswiftResources.StringResource { .init(key: "input_repeat_password", tableName: "RegisterScreen", source: source, developmentValue: "Repeat the password*", comment: nil) }

      /// en translation: Register
      ///
      /// Key: register
      ///
      /// Locales: en, ru
      var register: RswiftResources.StringResource { .init(key: "register", tableName: "RegisterScreen", source: source, developmentValue: "Register", comment: nil) }
    }

    /// This `_R.string.searchScreen` struct is generated, and contains static references to 1 localization keys.
    struct searchScreen {
      let source: RswiftResources.StringResource.Source

      /// en translation: Enter client name
      ///
      /// Key: enter_client_name
      ///
      /// Locales: en, ru
      var enter_client_name: RswiftResources.StringResource { .init(key: "enter_client_name", tableName: "SearchScreen", source: source, developmentValue: "Enter client name", comment: nil) }
    }

    /// This `_R.string.settingsScreen` struct is generated, and contains static references to 3 localization keys.
    struct settingsScreen {
      let source: RswiftResources.StringResource.Source

      /// en translation: Subscription information
      ///
      /// Key: information_subscribe
      ///
      /// Locales: en, ru
      var information_subscribe: RswiftResources.StringResource { .init(key: "information_subscribe", tableName: "SettingsScreen", source: source, developmentValue: "Subscription information", comment: nil) }

      /// en translation: View my services
      ///
      /// Key: show_services
      ///
      /// Locales: en, ru
      var show_services: RswiftResources.StringResource { .init(key: "show_services", tableName: "SettingsScreen", source: source, developmentValue: "View my services", comment: nil) }

      /// en translation: Setup
      ///
      /// Key: title_screen
      ///
      /// Locales: en, ru
      var title_screen: RswiftResources.StringResource { .init(key: "title_screen", tableName: "SettingsScreen", source: source, developmentValue: "Setup", comment: nil) }
    }

    /// This `_R.string.startScreen` struct is generated, and contains static references to 2 localization keys.
    struct startScreen {
      let source: RswiftResources.StringResource.Source

      /// en translation: Go for it
      ///
      /// Key: go
      ///
      /// Locales: en, ru
      var go: RswiftResources.StringResource { .init(key: "go", tableName: "StartScreen", source: source, developmentValue: "Go for it", comment: nil) }

      /// en translation: Plan your workday with comfort
      ///
      /// Key: greeting_phrase
      ///
      /// Locales: en, ru
      var greeting_phrase: RswiftResources.StringResource { .init(key: "greeting_phrase", tableName: "StartScreen", source: source, developmentValue: "Plan your workday with comfort", comment: nil) }
    }
  }

  /// This `_R.color` struct is generated, and contains static references to 11 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }

    /// Color `AuthPlaceholderTextFieldColor`.
    var authPlaceholderTextFieldColor: RswiftResources.ColorResource { .init(name: "AuthPlaceholderTextFieldColor", path: [], bundle: bundle) }

    /// Color `AuthTextFieldColor`.
    var authTextFieldColor: RswiftResources.ColorResource { .init(name: "AuthTextFieldColor", path: [], bundle: bundle) }

    /// Color `Black`.
    var black: RswiftResources.ColorResource { .init(name: "Black", path: [], bundle: bundle) }

    /// Color `BrightRed`.
    var brightRed: RswiftResources.ColorResource { .init(name: "BrightRed", path: [], bundle: bundle) }

    /// Color `Clear`.
    var clear: RswiftResources.ColorResource { .init(name: "Clear", path: [], bundle: bundle) }

    /// Color `DarkOrange`.
    var darkOrange: RswiftResources.ColorResource { .init(name: "DarkOrange", path: [], bundle: bundle) }

    /// Color `SoftWhite`.
    var softWhite: RswiftResources.ColorResource { .init(name: "SoftWhite", path: [], bundle: bundle) }

    /// Color `TextButtonColor`.
    var textButtonColor: RswiftResources.ColorResource { .init(name: "TextButtonColor", path: [], bundle: bundle) }

    /// Color `Vinous`.
    var vinous: RswiftResources.ColorResource { .init(name: "Vinous", path: [], bundle: bundle) }

    /// Color `White`.
    var white: RswiftResources.ColorResource { .init(name: "White", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 27 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `Arrow`.
    var arrow: RswiftResources.ImageResource { .init(name: "Arrow", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ArrowBackSheet`.
    var arrowBackSheet: RswiftResources.ImageResource { .init(name: "ArrowBackSheet", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `BackArrow`.
    var backArrow: RswiftResources.ImageResource { .init(name: "BackArrow", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Background1`.
    var background1: RswiftResources.ImageResource { .init(name: "Background1", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Background2`.
    var background2: RswiftResources.ImageResource { .init(name: "Background2", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Filter`.
    var filter: RswiftResources.ImageResource { .init(name: "Filter", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `FirstBackground`.
    var firstBackground: RswiftResources.ImageResource { .init(name: "FirstBackground", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ForwardArrow`.
    var forwardArrow: RswiftResources.ImageResource { .init(name: "ForwardArrow", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `GreetingImage`.
    var greetingImage: RswiftResources.ImageResource { .init(name: "GreetingImage", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `HidePassword`.
    var hidePassword: RswiftResources.ImageResource { .init(name: "HidePassword", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `House`.
    var house: RswiftResources.ImageResource { .init(name: "House", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `LaunchScreen`.
    var launchScreen: RswiftResources.ImageResource { .init(name: "LaunchScreen", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `LeftLines`.
    var leftLines: RswiftResources.ImageResource { .init(name: "LeftLines", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Logo`.
    var logo: RswiftResources.ImageResource { .init(name: "Logo", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Person`.
    var person: RswiftResources.ImageResource { .init(name: "Person", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `PlusNote`.
    var plusNote: RswiftResources.ImageResource { .init(name: "PlusNote", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `PlusService`.
    var plusService: RswiftResources.ImageResource { .init(name: "PlusService", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `RightLines`.
    var rightLines: RswiftResources.ImageResource { .init(name: "RightLines", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Search`.
    var search: RswiftResources.ImageResource { .init(name: "Search", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `SecondBackground`.
    var secondBackground: RswiftResources.ImageResource { .init(name: "SecondBackground", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `SelectedHouse`.
    var selectedHouse: RswiftResources.ImageResource { .init(name: "SelectedHouse", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `SelectedProfile`.
    var selectedProfile: RswiftResources.ImageResource { .init(name: "SelectedProfile", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `SelectedSearch`.
    var selectedSearch: RswiftResources.ImageResource { .init(name: "SelectedSearch", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `SelectedSettings`.
    var selectedSettings: RswiftResources.ImageResource { .init(name: "SelectedSettings", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ServiceTagBackground`.
    var serviceTagBackground: RswiftResources.ImageResource { .init(name: "ServiceTagBackground", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ShowPassword`.
    var showPassword: RswiftResources.ImageResource { .init(name: "ShowPassword", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `TextFieldBackground`.
    var textFieldBackground: RswiftResources.ImageResource { .init(name: "TextFieldBackground", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    let bundle: Foundation.Bundle
    var uiApplicationSceneManifest: uiApplicationSceneManifest { .init(bundle: bundle) }

    func uiApplicationSceneManifest(bundle: Foundation.Bundle) -> uiApplicationSceneManifest {
      .init(bundle: bundle)
    }

    struct uiApplicationSceneManifest {
      let bundle: Foundation.Bundle

      let uiApplicationSupportsMultipleScenes: Bool = false

      var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest"], key: "_key") ?? "UIApplicationSceneManifest" }
      var uiSceneConfigurations: uiSceneConfigurations { .init(bundle: bundle) }

      func uiSceneConfigurations(bundle: Foundation.Bundle) -> uiSceneConfigurations {
        .init(bundle: bundle)
      }

      struct uiSceneConfigurations {
        let bundle: Foundation.Bundle
        var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations"], key: "_key") ?? "UISceneConfigurations" }
        var uiWindowSceneSessionRoleApplication: uiWindowSceneSessionRoleApplication { .init(bundle: bundle) }

        func uiWindowSceneSessionRoleApplication(bundle: Foundation.Bundle) -> uiWindowSceneSessionRoleApplication {
          .init(bundle: bundle)
        }

        struct uiWindowSceneSessionRoleApplication {
          let bundle: Foundation.Bundle
          var defaultConfiguration: defaultConfiguration { .init(bundle: bundle) }

          func defaultConfiguration(bundle: Foundation.Bundle) -> defaultConfiguration {
            .init(bundle: bundle)
          }

          struct defaultConfiguration {
            let bundle: Foundation.Bundle
            var uiSceneConfigurationName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneConfigurationName") ?? "Default Configuration" }
            var uiSceneDelegateClassName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate" }
          }
        }
      }
    }
  }

  /// This `_R.font` struct is generated, and contains static references to 6 fonts.
  struct font: Sequence {
    let bundle: Foundation.Bundle

    /// Font `Raleway-Bold`.
    var ralewayBold: RswiftResources.FontResource { .init(name: "Raleway-Bold", bundle: bundle, filename: "Raleway-Bold.ttf") }

    /// Font `Raleway-Regular`.
    var ralewayRegular: RswiftResources.FontResource { .init(name: "Raleway-Regular", bundle: bundle, filename: "Raleway-Regular.ttf") }

    /// Font `RedHatDisplay-Black`.
    var redHatDisplayBlack: RswiftResources.FontResource { .init(name: "RedHatDisplay-Black", bundle: bundle, filename: "RedHatDisplay-Black.ttf") }

    /// Font `RedHatDisplay-Medium`.
    var redHatDisplayMedium: RswiftResources.FontResource { .init(name: "RedHatDisplay-Medium", bundle: bundle, filename: "RedHatDisplay-Medium.ttf") }

    /// Font `RedHatDisplay-Regular`.
    var redHatDisplayRegular: RswiftResources.FontResource { .init(name: "RedHatDisplay-Regular", bundle: bundle, filename: "RedHatDisplay-Regular.ttf") }

    /// Font `RedHatDisplay-SemiBold`.
    var redHatDisplaySemiBold: RswiftResources.FontResource { .init(name: "RedHatDisplay-SemiBold", bundle: bundle, filename: "RedHatDisplay-SemiBold.ttf") }

    func makeIterator() -> IndexingIterator<[RswiftResources.FontResource]> {
      [ralewayBold, ralewayRegular, redHatDisplayBlack, redHatDisplayMedium, redHatDisplayRegular, redHatDisplaySemiBold].makeIterator()
    }
    func validate() throws {
      for font in self {
        if !font.canBeLoaded() { throw RswiftResources.ValidationError("[R.swift] Font '\(font.name)' could not be loaded, is '\(font.filename)' added to the UIAppFonts array in this targets Info.plist?") }
      }
    }
  }

  /// This `_R.file` struct is generated, and contains static references to 6 resource files.
  struct file {
    let bundle: Foundation.Bundle

    /// Resource file `Raleway-Bold.ttf`.
    var ralewayBoldTtf: RswiftResources.FileResource { .init(name: "Raleway-Bold", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `Raleway-Regular.ttf`.
    var ralewayRegularTtf: RswiftResources.FileResource { .init(name: "Raleway-Regular", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `RedHatDisplay-Black.ttf`.
    var redHatDisplayBlackTtf: RswiftResources.FileResource { .init(name: "RedHatDisplay-Black", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `RedHatDisplay-Medium.ttf`.
    var redHatDisplayMediumTtf: RswiftResources.FileResource { .init(name: "RedHatDisplay-Medium", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `RedHatDisplay-Regular.ttf`.
    var redHatDisplayRegularTtf: RswiftResources.FileResource { .init(name: "RedHatDisplay-Regular", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `RedHatDisplay-SemiBold.ttf`.
    var redHatDisplaySemiBoldTtf: RswiftResources.FileResource { .init(name: "RedHatDisplay-SemiBold", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
    }


    /// Storyboard `LaunchScreen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "LaunchScreen"
      func validate() throws {
        if UIKit.UIImage(named: "LaunchScreen", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'LaunchScreen' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
      }
    }
  }
}