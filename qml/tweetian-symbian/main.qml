import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import QtMobility.feedback 1.1

PageStackWindow {
    id: window
    initialPage: MainPage{ id: mainPage }
    showStatusBar: !inputContext.visible
    platformSoftwareInputPanelEnabled: true
    platformInverted: settings.invertedTheme

    Component.onCompleted: settings.loadSettings()

    Settings{ id: settings }
    Cache{ id: cache }
    Constant{ id: constant }

    ThemeEffect{ id: listItemHapticEffect; effect: ThemeEffect.BasicItem }
    ThemeEffect{ id: basicHapticEffect; effect: ThemeEffect.Basic }

    Text{
        anchors.top: parent.top
        anchors.left: parent.left
        visible: showStatusBar
        color: "white"
        font.pixelSize: constant.fontSizeMedium
        text: "Tweetian"
    }

    ToolTip{
        id: toolTip
        visible: false
        platformInverted: settings.invertedTheme
    }

    InfoBanner{
        id: infoBanner
        platformInverted: settings.invertedTheme

        function alert(alertText){
            infoBanner.text = alertText
            infoBanner.open()
            infoBannerHapticEffect.play()
        }

        function showHttpError(errorCode, errorMessage){
            if(errorCode === 0) alert(qsTr("Server or connection error"))
            else alert(qsTr("Error: %1").arg(errorMessage + "(" + errorCode + ")"))
        }

        ThemeEffect{ id: infoBannerHapticEffect; effect: ThemeEffect.NeutralTacticon }
    }

    Item{
        id: loadingRect
        anchors.fill: parent
        visible: false
        z: 2

        Rectangle{
            anchors.fill: parent
            color: "black"
            opacity: 0.5
        }

        BusyIndicator{
            visible: loadingRect.visible
            running: visible
            anchors.centerIn: parent
            height: constant.graphicSizeLarge
            width: constant.graphicSizeLarge
            platformInverted: !settings.invertedTheme
        }
    }

    QtObject{
        id: dialog

        property Component __openLinkDialog: null
        property Component __dynamicQueryDialog: null
        property Component __messageDialog: null
        property Component __tweetLongPressMenu: null

        function createOpenLinkDialog(link, pocketCallback, instapaperCallback){
            if(!__openLinkDialog) __openLinkDialog = Qt.createComponent("Dialog/OpenLinkDialog.qml")
            var showAddPageServices = pocketCallback && instapaperCallback ? true : false
            var prop = { link: link, showAddPageServices: showAddPageServices }
            var dialog = __openLinkDialog.createObject(pageStack.currentPage, prop)
            if(showAddPageServices){
                dialog.addToPocketClicked.connect(pocketCallback)
                dialog.addToInstapaperClicked.connect(instapaperCallback)
            }
        }

        function createQueryDialog(titleText, titleIcon, message, acceptCallback){
            if(!__dynamicQueryDialog) __dynamicQueryDialog = Qt.createComponent("Dialog/DynamicQueryDialog.qml")
            // Add another newline at the end of message is to fix the bug in QueryDialog (QQC's ver <= 1.1.0)
            var prop = { titleText: titleText, titleIcon: titleIcon, message: message.concat("\n") }
            var dialog = __dynamicQueryDialog.createObject(pageStack.currentPage, prop)
            dialog.accepted.connect(acceptCallback)
        }

        function createMessageDialog(titleText, message){
            if(!__messageDialog) __messageDialog = Qt.createComponent("Dialog/MessageDialog.qml")
            __messageDialog.createObject(pageStack.currentPage, { titleText: titleText, message: message })
        }

        function createTweetLongPressMenu(model){
            if(!__tweetLongPressMenu) __tweetLongPressMenu = Qt.createComponent("Dialog/LongPressMenu.qml")
            __tweetLongPressMenu.createObject(pageStack.currentPage, { model: model })
        }
    }
}
