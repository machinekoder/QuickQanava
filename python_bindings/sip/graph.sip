namespace qan {

class Graph: QQuickItem /NoDefaultCtors/
{
%TypeHeaderCode
#include <qanGraph.h>
%End

public:
    explicit Graph( QQuickItem* parent = nullptr );
    virtual ~Graph();

    QQuickItem* graphChildAt(qreal x, qreal y) const;

    qan::Edge* insertEdge( QObject* source, QObject* destination, QQmlComponent* edgeComponent = nullptr );
};

};
