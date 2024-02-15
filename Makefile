build-libimobiledevice:
	cd ./libimobiledevice && ./autogen.sh --prefix $(realpath .)/build && make && make install

build-zig-ios-example:
	cd ./zig-ios-example && zig build -Dtarget=aarch64-ios.17.2...17.2

