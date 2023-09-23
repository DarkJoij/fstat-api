module fstat_api.filesystem.props;

import std.format;

import fstat_api.serve;

public final class Size {
private:    
    alias SizeT = Tuple!(uint, string);

    SizeT getNormalSize(uint /* Fix name: */ _sizeInBytes) {
        // TODO: Release converter.

        return new Tuple!(uint, string)(0, "UB");
    }

public:
    const uint innerSize;
    const uint outerSize;
    const string unit;

    final this(uint innerSize) {
        this.innerSize = innerSize;

        SizeT sizeTuple = getNormalSize(innerSize);

        this.outerSize = sizeTuple.l;
        this.unit = sizeTuple.r;
    }

    override string toString() const {
        return format("%d%s", outerSize, unit);
    }
}
