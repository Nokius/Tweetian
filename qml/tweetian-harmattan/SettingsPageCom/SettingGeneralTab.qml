import QtQuick 1.1
import com.nokia.meego 1.0

Page{
    id: root

    Flickable{
        anchors.fill: parent
        contentHeight: switchColumn.height + 2 * switchColumn.anchors.topMargin

        Column{
            id: switchColumn
            anchors{ left: parent.left; right: parent.right; top: parent.top; topMargin: constant.paddingMedium }
            height: childrenRect.height
            spacing: constant.paddingMedium

            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 2 * constant.paddingMedium
                font.pixelSize: constant.fontSizeLarge
                color: constant.colorLight
                text: qsTr("Theme")
            }

            ButtonRow{
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 2 * constant.paddingMedium
                onVisibleChanged: {
                    if(visible) checkedButton = settings.invertedTheme ?  lightThemeButton : darkThemeButton
                }

                Button{
                    id: darkThemeButton
                    text: qsTr("Dark")
                    onClicked: settings.invertedTheme = false
                }

                Button{
                    id: lightThemeButton
                    text: qsTr("Light")
                    onClicked: settings.invertedTheme = true
                }
            }

            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 2 * constant.paddingMedium
                font.pixelSize: constant.fontSizeLarge
                color: constant.colorLight
                text: qsTr("Font size")
            }

            ButtonRow{
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 2 * constant.paddingMedium
                onVisibleChanged: {
                    if(visible) checkedButton = settings.largeFontSize ? largeFontSizeButton : smallFontSizeButton
                }

                Button{
                    id: smallFontSizeButton
                    text: qsTr("Small")
                    onClicked: settings.largeFontSize = false
                }

                Button{
                    id: largeFontSizeButton
                    text: qsTr("Large")
                    onClicked: settings.largeFontSize = true
                }
            }

            SettingSwitch{
                text: qsTr("Include #hashtags in reply")
                checked: settings.hashtagsInReply
                onCheckedChanged: settings.hashtagsInReply = checked
            }

            SettingSwitch{
                text: qsTr("Enable TwitLonger")
                checked: settings.enableTwitLonger
                infoButtonVisible: true
                onInfoClicked: dialog.createMessageDialog(qsTr("About TwitLonger"), infoText.twitLonger)
                onCheckedChanged: settings.enableTwitLonger = checked
            }
        }
    }
}
