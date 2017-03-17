# Rainmeter Bang Executor
Small program that can be used to execute Rainmeter bangs.

## Build
Use `build_debug.bat` when developing as this will retain the console. Use `build_release.bat` for releases as that will stop the console from showing up when running the executable.

## How to use
Create a shortcut to the executable and pass arguments via the shortcut's `Target` field, which can be found in the shortcut's `Properties` window.

You can either set the path to the Rainmeter executable in the `RainmeterBangExecutor.json` file, which should be in the same folder as `RainmeterBangExecutor.exe`, or include it as the first argument in the shortcut's `Target` field (remember to enclose the path in quotation marks, if the path contains whitespace).

Add [Rainmeter bangs](https://docs.rainmeter.net/manual/bangs/) as additional arguments in the shortcut's `Target` field as you wish. For example, `"!ToggleFade" "SomeConfigName"`.

You can use Windows' built-in ability to assign hotkeys to shortcuts to execute the Rainmeter bangs defined in the shortcut's `Target` field.