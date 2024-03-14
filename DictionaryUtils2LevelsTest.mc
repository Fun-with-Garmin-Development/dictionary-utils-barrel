import Toybox.Lang;
import Toybox.System;
import Toybox.Test;

(:test)
module DictionaryUtilsBarrel {
    (:test)
    function test2Levels1(logger as Logger) as Boolean {
        var dict1 = { "level2" => { "key1" => 1 } };
        var dict2 = { "level2" => { "key1" => 1 } };
        dumpInfo(dict1, dict2, logger);
        var comparison = compareDictionaries(dict1, dict2);
        logger.debug(Lang.format("comparison: $1$", [comparison]));
        Test.assertMessage(comparison, "Dictionaries are equal");
        return true;
    }

    (:test)
    function test2Levels2(logger as Logger) as Boolean {
        var dict1 = { "level2" => { "key1" => 1, "key2" => 2 } };
        var dict2 = { "level2" => { "key2" => 2, "key1" => 1 } };
        dumpInfo(dict1, dict2, logger);
        var comparison = compareDictionaries(dict1, dict2);
        logger.debug(Lang.format("comparison: $1$", [comparison]));
        Test.assertMessage(comparison, "Dictionaries are equal");
        return true;
    }

    (:test)
    function test2Levels3(logger as Logger) as Boolean {
        var dict1 = { "level2" => { "key1" => 1, "key2" => 2 } };
        var dict2 = { "level2" => { "key1" => 1, "key2" => 2, "key3" => 3 } };
        dumpInfo(dict1, dict2, logger);
        var comparison = compareDictionaries(dict1, dict2);
        logger.debug(Lang.format("comparison: $1$", [comparison]));
        Test.assertMessage(!comparison, "Dictionaries are not equal");
        return true;

    }
}
