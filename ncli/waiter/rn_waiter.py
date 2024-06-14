from .abstract_waiter import AbstractWaiter
from filegen import *

class ReactNativeWaiter(AbstractWaiter):

    def __init__(self):
        super(ReactNativeWaiter, self).__init__()

    def work(self, **_):
        self.box_print("Setup React Native project")
        group_id = self.ask("group_id", "tech.cuda")
        artifact_id = self.ask("artifact_id", "appdemo")
        name = self.ask("app name", "AppDemo")
        version = self.ask("version", "0.1.0")
        super().work(default_loc=name)

        StaticResource("quickstart-rn/.bundle").save(f"{self.project_loc}/.bundle")
        StaticResource("quickstart-rn/__tests__").save(f"{self.project_loc}/__tests__")

        # android 子项
        self.mkdir(f"android/app/src/main/java/{group_id.replace('.', '/')}/{artifact_id}")

        StaticResource("quickstart-rn/android/app/debug.keystore")\
            .save(f"{self.project_loc}/android/app/debug.keystore")

        StaticResource("quickstart-rn/android/gradle")\
            .save(f"{self.project_loc}/android/gradle")
        StaticResource("quickstart-rn/android/gradlew.bat")\
            .save(f"{self.project_loc}/android/gradlew.bat")
        StaticResource("quickstart-rn/android/gradlew")\
            .save(f"{self.project_loc}/android/gradlew")

        DynamicResource("quickstart-rn/android/build.gradle")\
            .set("version", version) \
            .set("group_id", group_id) \
            .save(f"{self.project_loc}/android/build.gradle")
        DynamicResource("quickstart-rn/android/settings.gradle")\
            .set("name", name) \
            .save(f"{self.project_loc}/android/settings.gradle")
        StaticResource("quickstart-rn/android/gradle.properties")\
            .save(f"{self.project_loc}/android/gradle.properties")

        DynamicResource("quickstart-rn/android/app/build.gradle")\
            .set("groupId", group_id) \
            .set("artifactId", artifact_id) \
            .save(f"{self.project_loc}/android/app/build.gradle")

        StaticResource("quickstart-rn/android/app/src/debug")\
            .save(f"{self.project_loc}/android/app/src/debug")

        DynamicResource("quickstart-rn/android/app/src/main/java/com/app/MainApplication.kt")\
            .set("groupId", group_id) \
            .set("artifactId", artifact_id) \
            .save(f"{self.project_loc}/android/app/src/main/java/{group_id.replace('.', '/')}/{artifact_id}/MainApplication.kt")

        DynamicResource("quickstart-rn/android/app/src/main/java/com/app/MainActivity.kt")\
            .set("groupId", group_id) \
            .set("artifactId", artifact_id) \
            .set("name", name) \
            .save(f"{self.project_loc}/android/app/src/main/java/{group_id.replace('.', '/')}/{artifact_id}/MainActivity.kt")

        StaticResource("quickstart-rn/android/app/proguard-rules.pro")\
            .save(f"{self.project_loc}/android/app/proguard-rules.pro")

        StaticResource("quickstart-rn/android/app/src/main/AndroidManifest.xml")\
            .save(f"{self.project_loc}/android/app/src/main/AndroidManifest.xml")

        StaticResource("quickstart-rn/android/app/src/main/res")\
            .save(f"{self.project_loc}/android/app/src/main/res")
        DynamicResource("quickstart-rn/android/app/src/main/res/values/strings.xml")\
            .set("name", name) \
            .save(f"{self.project_loc}/android/app/src/main/res/values/strings.xml")

        # ios 子项
        StaticResource("quickstart-rn/ios/App/Images.xcassets")\
             .save(f"{self.project_loc}/ios/{name}/Images.xcassets")
        StaticResource("quickstart-rn/ios/App/AppDelegate.h")\
             .save(f"{self.project_loc}/ios/{name}/AppDelegate.h")
        DynamicResource("quickstart-rn/ios/App/AppDelegate.mm")\
             .set("name", name)\
             .save(f"{self.project_loc}/ios/{name}/AppDelegate.mm")
        DynamicResource("quickstart-rn/ios/App/Info.plist")\
             .set("name", name)\
             .save(f"{self.project_loc}/ios/{name}/Info.plist")
        DynamicResource("quickstart-rn/ios/App/LaunchScreen.storyboard")\
             .set("name", name)\
             .save(f"{self.project_loc}/ios/{name}/LaunchScreen.storyboard")
        StaticResource("quickstart-rn/ios/App/main.m")\
             .save(f"{self.project_loc}/ios/{name}/main.m")

        DynamicResource("quickstart-rn/ios/App.xcodeproj/project.pbxproj") \
             .set("name", name)\
             .save(f"{self.project_loc}/ios/{name}.xcodeproj/project.pbxproj")
        DynamicResource("quickstart-rn/ios/App.xcodeproj/xcshareddata/xcschemes/App.xcscheme") \
             .set("name", name)\
             .save(f"{self.project_loc}/ios/{name}.xcodeproj/xcshareddata/xcschemes/{name}.xcscheme")

        StaticResource("quickstart-rn/ios/AppTests/Info.plist")\
             .save(f"{self.project_loc}/ios/{name}Test/Info.plist")
        DynamicResource("quickstart-rn/ios/AppTests/AppTests.m")\
             .set("name", name)\
             .save(f"{self.project_loc}/ios/{name}Test/{name}Tests.m")

        StaticResource("quickstart-rn/ios/.xcode.env")\
             .save(f"{self.project_loc}/ios/.xcode.env")
        DynamicResource("quickstart-rn/ios/Podfile")\
             .set("name", name)\
             .save(f"{self.project_loc}/ios/Podfile")

        # react-native 子项
        StaticResource("quickstart-rn/.eslintrc.js")\
             .save(f"{self.project_loc}/.eslintrc.js")
        StaticResource("quickstart-rn/.prettierrc.js")\
             .save(f"{self.project_loc}/.prettierrc.js")
        StaticResource("quickstart-rn/.watchmanconfig")\
             .save(f"{self.project_loc}/.watchmanconfig")
        DynamicResource("quickstart-rn/app.json")\
             .set("name", name) \
             .save(f"{self.project_loc}/app.json")
        StaticResource("quickstart-rn/App.tsx")\
             .save(f"{self.project_loc}/App.tsx")
        StaticResource("quickstart-rn/babel.config.js")\
             .save(f"{self.project_loc}/babel.config.js")
        StaticResource("quickstart-rn/Gemfile")\
             .save(f"{self.project_loc}/Gemfile")
        StaticResource("quickstart-rn/index.js")\
             .save(f"{self.project_loc}/index.js")
        StaticResource("quickstart-rn/jest.config.js")\
             .save(f"{self.project_loc}/jest.config.js")
        StaticResource("quickstart-rn/metro.config.js")\
             .save(f"{self.project_loc}/metro.config.js")
        DynamicResource("quickstart-rn/package.json")\
             .set("name", name) \
             .set("version", version) \
             .save(f"{self.project_loc}/package.json")
        StaticResource("quickstart-rn/tsconfig.json")\
             .save(f"{self.project_loc}/tsconfig.json")
        StaticResource("quickstart-rn/yarn.lock")\
             .save(f"{self.project_loc}/yarn.lock")

        StaticResource("quickstart-rn/view")\
             .save(f"{self.project_loc}/view")

        print("Android SDK setup tutorial: https://stackoverflow.com/questions/62635201/android-sdk-not-found-for-react-native")
