module fstat_api.errors;

import std.format;

public class FStatApiError : Exception {
public:
    final this(T...)(T args) {
        super(format(args));
    }
}

public class IterIndexOutOfBoundException : FStatApiError {
public:
    final this(T...)(T args) {
        super(args);
    }
}
