# Dictionary Utils Barrel

This project includes helper functions for working with dictionaries in Monkey C.

The utils include:

-   `compareDictionaries()` that checks if two dictionaries are equal (by comparing their keys and values)
-   `mergeDictionaries()` that adds keys/values of two dictionaries

## Usage

As any other barrel, in order to use this one, developers will need to add it to the current project.
This can be done through the
[Visual Studio Code's Monkey C Extention](https://marketplace.visualstudio.com/items?itemName=garmin.monkey-c)
("Monkey C: Configure Monkey Barrel" option) or by manually editing a project’s Jungle and manifest file.

See ["How to Include Barrels"](https://developer.garmin.com/connect-iq/core-topics/shareable-libraries) or
["Monkey Barrel Management"](https://developer.garmin.com/connect-iq/reference-guides/jungle-reference/#junglereferenceguide)
for details.

Once it has been added to a project, the compiler starts "to see" the barrel.
There is no need for importing it, unless you want to use alias for the library.

You can obtain the compiled .barrel file from project's [releases page](https://github.com/Fun-with-Garmin-Development/dictionary-utils-barrel/releases).

## Description

### Merge dictionaries

This function adds or overwrites values from one dictionary into another dictionary.

The syntax is:

```javascript
var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
```

In this case, values from `dict2` will be copied to `dict1`. For convenience, dict1 is returned as function result.

> Please, note that **dict1 object will change**.

Let's take a look at some basic examples, to illustrate the funcionality:

```javascript
    var dict1 = { "a" => 1, "b" => 2, "c" => 3 };
    var dict2 = { "d" => 4, "e" => 5, "f" => 6 };

    var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
```

The code above produces the following result:

```
{"a"=>1, "b"=>2, "c"=>3, "d"=>4, "e"=>5, "f"=>6}
```

More advanced example

```javascript
    var dict1 = { "a" => 1, "b" => { "k1" => "v1", "k2" => "v2" } };
    var dict2 = { "b" => { "k2" => "v3" } };

    var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
```

will result with:

```
 { "a" => 1, "b" => { "k1" => "v1", "k2" => "v3" } }
```

### Compare dictionaries

This function compares two dictionaries and returns `true` if they are equal and `false` otherwise.
The function test value equality. The objects here are considered equal, when they have the same keys and corresponding values.

> ATTOW, Connect IQ SDK (6.4.2) doesn't provide reliable way for comparing dictionaries by value. For example, `{ "a1" => 1, "a2" => 2 }` and `{ "a2" => 2, "a1" => 1 }` are two different dictionaries (when you compare them with `equals()`). Please note, that the keys and corresponding values are the same.

The syntax is:

```javascript
var result = DictionaryUtilsBarrel.compareDictionaries(dict1, dict2);
```

A few examples:

```javascript
    var dict1 = { "a" => 1, "b" => 2, "c" => 3 };
    var dict2 = { "b" => 2, "a" => 1, "c" => 3 };

    var result = DictionaryUtilsBarrel.compareDictionaries(dict1, dict2);
```

The code above returns `true`.

```javascript
    var dict1 = { "a" => 1, "b" => 2, "c" => 3 };
    var dict2 = { "b" => 2, "a" => 1 };

    var result = DictionaryUtilsBarrel.compareDictionaries(dict1, dict2);
```

returns `false` as `dict2` doesn't contain element `c` .

```javascript
    var dict1 = { "a" => 1, "b" => { "k1" => "v1", "k2" => "v2" } };
    var dict2 = { "a" => 1, "b" => { "k1" => "v1", "k2" => "different" } };

    var result = DictionaryUtilsBarrel.compareDictionaries(dict1, dict2);
```

will result with `false` (`k2` has different value).

## Build and export

You can build and export the barrel using the IDE (i.e. "Monkey C: Export Project" or "Monkey C: Build Current Project" commands of [Monkey C Extention](https://marketplace.visualstudio.com/items?itemName=garmin.monkey-c) for VS Code) or with the following command:

```bash
export VERSION="0.1.0"
barrelbuild -o bin/dictionary-utils-$version.barrel -f monkey.jungl
```

See: ["Exporting a Monkey Barrel"](https://developer.garmin.com/connect-iq/core-topics/shareable-libraries/#:~:text=Exporting%20a%20Monkey%20Barrel) for details.

## Dependencies

The project has no dependencies.

## Contributing

If you want to contribute to this project, please fork the repository and create a pull request, or open an issue for discussion.

## License

This project is licensed under the Apache License 2.0. This means you can freely use, modify, and distribute it, under the terms of the Apache License. You can read the full text of the license at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).
