import UIKit

// MARK: Structures

// View more about Structures: https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html
struct LoginCredentials {
    var userName: String
    var password: String
}

// View more about Structures: https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html
struct ElementIdentifier {
    var id: String
    var type: ElementType
}


// MARK: Enumerations

// View more about Enumerations: https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
enum ElementType {
    case button, textField, cell, table, staticText
}

enum Elements: String, CustomStringConvertible {
    case loginButton, userNameTextField, passwordTextField, userIcon, settingsIcon

    var description: String { return rawValue }
}

// MARK: Array

/* This constan is an array (list) of elements of same type.
Type of every single element is: "Elements:ElementIdentifier"
First part of element (Elements) is enum which in this case is representing UI elements in app
Second part of element (ElementIdentifier) is Structure which contains 2 variables:
       - first one (id) represents string ID of elemet, this id is defined somewhere in app code as accessibbilityIdentifier
       - second one (type) represents type of UI elements, types of elements is defined in enum "ElementType"
 */
let ottChildPairingElementList: [Elements: ElementIdentifier] = [
    .loginButton: ElementIdentifier(id: "loginButtonID", type: .button),
    .userNameTextField: ElementIdentifier(id: "userNameID", type: .textField),
    .passwordTextField: ElementIdentifier(id: "passwordID", type: .textField),
    .userIcon: ElementIdentifier(id: "userIconCell", type: .cell),
    .settingsIcon: ElementIdentifier(id: "settingsIconID", type: .button)
]


// MARK: Classes and fuctions

/* https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html
 Recomeded catogories to read:
                        - Basic Operators
                        - Control Flow
                        - Functions
                        - Closures
                        - Inheritance
 */


// Class "BaseTest" is used for basic functionality which we can share across the views. There should be non specific functionality
class BaseTest {

    func enterTextInToTextField(text: String, textField: Elements) {
        print("Entering text: \(text) in to textfield \(textField.description)")
    }

    func pressElement(button: Elements) {
        print("Pressing Button \(button.description)")
    }

}

class LoginViewRobot: BaseTest {

/* We use tag '@discardableResult' to handle warning when you are not use return value of func
     We use current class as return value because we want to write fincs in "chain" in test features (see in "TestFeature")
     if we wouldn't use this tag, last of called function will have unused result of function and waring will appear
 */
    @discardableResult
    func enterCredentials(credentials: LoginCredentials) -> LoginViewRobot {
        enterTextInToTextField(text: credentials.userName, textField: Elements.userNameTextField)
        enterTextInToTextField(text: credentials.password, textField: Elements.passwordTextField)
        return self  /* "return self" means you will get 'LoginViewRobot' as a result of call of this func,
                    that means you can call another function from 'LoginViewRobot' right after call previous func from current class  */
    }

    @discardableResult
    func pressLoginButton() -> LoginViewRobot {
        pressElement(button: Elements.loginButton)
        return self
    }
}

/*
 "class DashbbboardViewRobot" is definition of class with name "DashbbboardViewRobot"
 ": BaseTest" defined form which class will defined class inherit (in this case 'DashbbboardViewRobot' inherit from 'BaseTest')
  Class can inherit methods, properties, and other characteristics from another class
 */
class DashbbboardViewRobot: BaseTest {

    @discardableResult
    func pressUserIcon() -> DashbbboardViewRobot {
        pressElement(button: Elements.userIcon)
        return self
    }

    @discardableResult
    func pressSettingsIcon() -> DashbbboardViewRobot {
        pressElement(button: Elements.settingsIcon)
        return self
    }
}



class TestFeature {
    lazy var loginRobot = LoginViewRobot() // lazy variable means this variable will exists just if needed
    lazy var dashboardRobot = DashbbboardViewRobot()

    let credentials = LoginCredentials(userName: "user1", password: "abcd123") // This is example how to assign value to constant of type LoginCredentials

    func testFirstTest() {
        loginRobot
            .enterCredentials(credentials: credentials)
            .pressLoginButton()
        dashboardRobot
            .pressUserIcon()
            .pressSettingsIcon()
    }

}
