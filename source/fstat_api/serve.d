module fstat_api.serve;

import std.array;
import std.format;

import fstat_api.errors;

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

public final class Iter(T) {
private:
    const T[] tArray;
    uint index;

    T getCurrent(uint forwardOn) {
        uint peekingIndex = index + forwardOn;

        if (peekingIndex >= uint.max) {
            throw new IterIndexOutOfBoundException("Index out of bounds: %d", index);
        }

        return tArray[peekingIndex];
    }

public:
    final this(T[] elements...) {
        this.tArray = array(elements);
    }

    void next() { ++index; }

    T getCurrent() {
        return getCurrent(0);
    }

    bool nextExists() {
        try {
            getCurrent(1);
            return true;
        } catch (Exception _exception) {
            return false;
        }        
    }
}
