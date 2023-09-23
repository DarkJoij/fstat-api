module fstat_api.serve;

import std.format;

public final class Tuple(L, R) {
public:
    const L l;
    const R r;

    final this(L l, R r) {
        this.l = l;
        this.r = r;
    }

    override string toString() const {
        return format("Tuple(%s, %s)", l, r);
    } 
}
