namespace qan {

class Edge: QObject /NoDefaultCtors/
{
%TypeHeaderCode
#include <qanGraph.h>
%End
    explicit Edge();
    virtual ~Edge();
};

};
