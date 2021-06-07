immutable string hostname;
immutable char* hostnamez;

private enum HOST_NAME_MAX = 255; // XXX: replace with importC when available
private char[HOST_NAME_MAX + 1] buf;
private extern (C) int gethostname(char* name, size_t len);

shared static this() {
    import std.exception : assumeUnique;
    import std.string : fromStringz;

    assert(0 == gethostname(buf.ptr, HOST_NAME_MAX), "gethostname() failed");
    hostnamez = cast(immutable char*) buf.ptr;
    hostname = buf.ptr.fromStringz.assumeUnique;
}

