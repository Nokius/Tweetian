/*
    Copyright (C) 2012 Dickson Leong
    This file is part of Tweetian.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0

Item {
    id: root

    property string text: ""
    property alias maximumValue: slider.maximumValue
    property alias minimumValue: slider.minimumValue
    property alias stepSize: slider.stepSize
    property alias value: slider.value
    property alias fontSize: mainText.font.pixelSize
    property string valueText: (slider.value == 0) ? qsTr("Off") : value

    signal released

    implicitWidth: parent.width
    height: mainText.height + slider.height + 2 * constant.paddingMedium + slider.anchors.margins

    Text {
        id: mainText
        anchors { top: parent.top; left: parent.left; margins: constant.paddingMedium }
        font.pixelSize: constant.fontSizeLarge
        color: constant.colorLight
        text: root.text
    }

    Slider {
        id: slider
        anchors { top: mainText.bottom; left: parent.left; right: parent.right; margins: constant.paddingSmall }
        enabled: root.enabled
        minimumValue: 0
        valueText: root.valueText
        onPressedChanged: if (!pressed) root.released()
    }
}
