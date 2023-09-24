module fstat_api.filesystem.props;

import std.format;

import fstat_api.serve;

public final class Size {
private:    
    alias SizeT = Tuple!(uint, string);
    Iter!(string) units = new Iter!(string)("B", "KB", "MB", "GB", "TB", /* "PB", "EB" */);

    SizeT getNormalSize(uint size) {        
        while (size / 1024 >= 1 && units.nextExists()) {
            size = cast(uint) (size / 1024);
            units.next();
        }

        return new Tuple!(uint, string)(size, units.getCurrent());
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

unittest {
    Size s = new Size(2048);

    assert(s.outerSize == 2);
    assert(s.unit == "KB");
}
