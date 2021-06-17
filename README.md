hostname(3d) - 3d

# NAME

**hostname** - Get the environment's hostname with
gethostname(2)

# SYNOPSIS

**import hostname : hostname, hostnamez;**

**immutable string hostname;**

**immutable char\* hostnamez;**

# DESCRIPTION

The **hostname** module has a shared static initializer that calls
gethostname(2)
once, into a static buffer, and then initializes **string** and **immutable char\*&zwnj;** typed variables
with the contents of that buffer, without copying.

A failure of
gethostname(2)
is treated as an unrecoverable error, guarded by an assert().

# EXAMPLE

	#! /usr/bin/env dub
	/+ dub.sdl:
	    dependency "hostname" version="~>0.1.2"
	+/
	
	void main() {
	    import std.stdio : writeln;
	    import hostname : hostname;
	
	    writeln("hostname: ", hostname);
	}

# BETTERC EXAMPLE

	#! /usr/bin/env dub
	/+ dub.sdl:
	    dependency "hostname" version="~>0.1.2"
	    buildOptions "betterC"
	+/
	
	extern(C) void main() {
	    import core.stdc.stdio : printf;
	    import hostname : hostnamez;
	
	    printf("hostname: %s\n", hostnamez);
	}

# SEE ALSO

gethostname(2),
Sys::Hostname(3pm)

# BUGS

Due to issue #22031 (crt\_constructor functions can't initialize immutable/const variables) the **hostname**
and **hostnamez** variables aren't immutable when the library is compile with -betterC.

# FUTURE DIRECTIONS

This module hard-codes the value of **HOST\_NAME\_MAX**. When importC is available, that should be used instead.

Perhaps the statically initialized hostnames should be in an optional
submodule, separate from a module that just wraps
gethostname(2)?
The current implementation is what I've wanted 100% of the time, but in other environments hostnames can be subject to change.

# COLOPHON

This page is part of the 0.1.2 release of the hostname DUB package.
This package can be found at https://code.dlang.org/packages/hostname/.
Issues should be submitted to https://github.com/jrfondren/hostname-d/issues.

D - June 7, 2021
