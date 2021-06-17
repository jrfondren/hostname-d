private enum HOST_NAME_MAX = 255; // XXX: replace with importC when available
private char[HOST_NAME_MAX + 1] buf;
private extern (C) int gethostname(char* name, size_t len);

version (D_BetterC) {
    string hostname; // can't be immutable due to issue #22031
    char* hostnamez;

    pragma(crt_constructor) extern (C) void hostname_initialize() {
        import std.exception : assumeUnique;
        import std.string : fromStringz;

        if (gethostname(buf.ptr, HOST_NAME_MAX))
            assert(0, "gethostname() failed");
        hostnamez = buf.ptr;
        hostname = buf.ptr.fromStringz.assumeUnique;
    }
} else {
    immutable string hostname;
    immutable char* hostnamez;

    shared static this() {
        import std.exception : assumeUnique;
        import std.string : fromStringz;

        if (gethostname(buf.ptr, HOST_NAME_MAX))
            assert(0, "gethostname() failed");
        hostnamez = cast(immutable char*) buf.ptr;
        hostname = buf.ptr.fromStringz.assumeUnique;
    }
}
