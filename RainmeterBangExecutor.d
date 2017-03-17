import std.stdio, std.process, std.file, std.path, std.json;

void main(string[] args)
{
	if(args.length > 1)
	{
		string working_directory_path = getcwd();
		string config_file_path = buildPath(working_directory_path, "RainmeterBangExecutor.json");
		writeln(config_file_path);
		string[] final_arguments = [];
		if(exists(config_file_path)) // Config file exists, use that to get the path to the Rainmeter executable
		{
			writeln("Config file exists...");
			JSONValue config = parseJSON(readFile(config_file_path));
			if(settingExists(config, "rainmeter_executable_path"))
			{
				final_arguments ~= getStringSetting(config, "rainmeter_executable_path");
				final_arguments ~= args[1..$];
			}
		} else { // Config file does not exist, first argument must be the path to the Rainmeter executable
			writeln("Config file does not exist, expecting Rainmeter path as first argument...");
			final_arguments ~= args[1..$];
		}
		if(final_arguments.length > 0 && !exists(final_arguments[0]))
		{
			writeln("Rainmeter path is invalid!");
		} else if(final_arguments.length <= 1) {
			writeln("Not enough arguments:");
			writeln(final_arguments[0..$]);
		} else {
			writeln("Rainmeter path: " ~ final_arguments[0]);
			writeln("Executing with the following arguments:");
			writeln(final_arguments[1..$]);
			execute(final_arguments);
		}
	} else {
		writeln("Expected at least one argument to be passed.");
	}
}

string readFile(string filepath) {
	if (exists(filepath)) {
		string contents = cast(string) read(filepath);
		if (contents != null) {
			return contents;
		}
	}
	return null;
}

bool settingExists(JSONValue object, string key) {
	int* key_in_json = cast(int*) (key in object);
	if (key_in_json != null) {
		return true;
	}
	return false;
}

string getStringSetting(JSONValue object, string key) {
	if (settingExists(object, key)) {
		if (object[key].type == JSON_TYPE.STRING) {
			return object[key].str;
		}
	}
	return null;
}

auto getArraySetting(JSONValue object, string key) {
	if (settingExists(object, key)) {
		if (object[key].type == JSON_TYPE.ARRAY) {
			return object[key].array;
		}
	}
	return null;
}

auto getObjectSetting(JSONValue object, string key) {
	if (settingExists(object, key)) {
		if (object[key].type == JSON_TYPE.OBJECT) {
			return object[key].object;
		}
	}
	return null;
}
