# TextractorSender Extension

TextractorSender is an extension for [Textractor](https://github.com/Artikash/Textractor) that sends textract-ed lines along with some information to other applications through a websocket on port 9001.

For example, this project may be used with:
- [exSTATic](https://github.com/KamWithK/exSTATic)
- [renji-xd texthooker-ui](https://renji-xd.github.io/texthooker-ui/)

This fork integrates the project with CMake and vcpkg in order to create reproducible builds.

## Building
Needless to say, this can only be built on Windows. Built using Visual Studio 2019; also tested with Visual Studio 2022. Other versions or build systems may or may not work.

This project uses CMake and vcpkg, both of which you may easily install using [scoop](https://scoop.sh/).

```cmd
> scoop install cmake
> scoop install vcpkg
```

To build the project, either run `build.bat` or manually run the following commands (replacing `x86-windows-static` with `x64-windows-static` for 64-bit builds):
```cmd
> cmake --preset=x86-windows-static
> cmake --build build --config Release
```

The Visual Studio solution will end up in the `build` directory. The DLL will be built to `build\Release\TextractorSender.dll` (this is the same as an .xdll-file).

To install it to Textractor, click on Extensions, right click and add the dll file. Note that this will not work if you have installed Textractor to `C:\Program Files` or similar as this would require administrator privileges. In this case, you must manually move the dll to the same folder as `Textractor.exe` before adding it.

## Alternatives
There are other texthooker extensions that may be worth trying:
- [textractor_websocket (kuroahna)](https://github.com/kuroahna/textractor_websocket) (written in Rust)
- [textractor-websocket (sadolit)](https://github.com/sadolit/textractor-websocket) (written in Rust)

