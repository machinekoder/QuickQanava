/*
 Copyright (c) 2008-2017, Benoit AUTHEMAN All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author or Destrat.io nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL AUTHOR BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick                   2.8
import QtQuick.Controls          2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts           1.3
import Qt.labs.platform          1.0    // ColorDialog

import QuickQanava 2.0 as Qan
import "qrc:/QuickQanava" as Qan
import "." as Qan

Qan.GraphView {
    id: graphView
    anchors.fill: parent
    navigable   : true
    graph: Qan.Graph {
        id: graph
        connectorEnabled: true
        Component.onCompleted: {
            var n11 = graph.insertNode()
            n11.label = "N11"; n11.item.x = 50; n11.item.y = 50
            var n12 = graph.insertNode()
            n12.label = "N12"; n12.item.x = 50; n12.item.y = 150

            var n13 = graph.insertNode()
            n13.label = "N13"; n13.item.x = 50; n13.item.y = 250

            var n2 = graph.insertNode()
            n2.label = "N2"; n2.item.x = 250; n2.item.y = 100

            var p1 = graph.insertInPort(n2, Qan.NodeItem.Left);
            p1.label = "IN #1"
            var p2 = graph.insertInPort(n2, Qan.NodeItem.Left);
            p2.label = "IN #2"

            var e1 = graph.insertEdge(n11, n2);
            var e2 = graph.insertEdge(n12, n2);
            graph.bindEdgeDestination(e1, p1)
            graph.bindEdgeDestination(e2, p2)


            graph.setConnectorSource(n2)
        }
    }
}  // Qan.GraphView

