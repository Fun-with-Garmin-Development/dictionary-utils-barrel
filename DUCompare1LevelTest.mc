import Toybox.Lang;
import Toybox.System;
import Toybox.Test;

(:test)
module DictionaryUtilsBarrel {
    (:test)
    function testBasicSingleKey(logger as Logger) as Boolean {
        var dict1 = { "key1" => 1 };
        var dict2 = { "key1" => 1 };
        dumpInfo(dict1, dict2, logger);
        var comparison = compareDictionaries(dict1, dict2);
        logger.debug(Lang.format("comparison: $1$", [comparison]));
        Test.assertMessage(comparison, "Dictionaries are equal");
        return true;
    }

    (:test)
    function testBasicSingleKeyDifferentValue(logger as Logger) as Boolean {
        var dict1 = { "key1" => 1 };
        var dict2 = { "key1" => 2 };
        dumpInfo(dict1, dict2, logger);
        var comparison = compareDictionaries(dict1, dict2);
        logger.debug(Lang.format("comparison: $1$", [comparison]));
        Test.assertMessage(!comparison, "Dictionaries are equal");
        return true;
    }

    (:test)
    function testBasicSameDifferentKeys(logger as Logger) as Boolean {
        var dict1 = { "key1" => 1 };
        var dict2 = { "key2" => 1 };
        dumpInfo(dict1, dict2, logger);
        var comparison = compareDictionaries(dict1, dict2);
        logger.debug(Lang.format("comparison: $1$", [comparison]));
        Test.assertMessage(!comparison, "Dictionaries are equal");
        return true;
    }

    (:test)
    function testBasic2Keys(logger as Logger) as Boolean {
        var dict1 = { "key1" => 1, "key2" => 2 };
        var dict2 = { "key1" => 1, "key2" => 2 };
        dumpInfo(dict1, dict2, logger);
        var comparison = compareDictionaries(dict1, dict2);
        logger.debug(Lang.format("comparison: $1$", [comparison]));
        Test.assertMessage(comparison, "Dictionaries are equal");
        return true;
    }

    (:test)
    function testBasic2KeysInverted(logger as Logger) as Boolean {
        var dict1 = { "key1" => 1, "key2" => 2 };
        var dict2 = { "key2" => 2, "key1" => 1 };
        dumpInfo(dict1, dict2, logger);
        var comparison = compareDictionaries(dict1, dict2);
        logger.debug(Lang.format("comparison: $1$", [comparison]));
        Test.assertMessage(comparison, "Dictionaries are equal");
        return true;
    }
}
