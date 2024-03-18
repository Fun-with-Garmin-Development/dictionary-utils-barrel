import Toybox.Lang;
import Toybox.System;
import Toybox.Test;

(:test)
module DictionaryUtilsBarrel {
    (:test)
    function testMergeBothEmpty(logger as Logger) as Boolean {
        var dict1 = {};
        var dict2 = {};
        var expected = {};
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        dumpMerged(dict1, dict2, logger);
        Test.assert(DictionaryUtilsBarrel.compareDictionaries(result, expected));
        return true;
    }

    (:test)
    function testMergeFirstEmpty(logger as Logger) as Boolean {
        var dict1 = {};
        var dict2 = { "level2" => { "key2" => 2, "key1" => 1 } };
        var expected = { "level2" => { "key2" => 2, "key1" => 1 } };
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        dumpMerged(dict1, dict2, logger);
        Test.assert(DictionaryUtilsBarrel.compareDictionaries(result, expected));
        return true;
    }

    (:test)
    function testMergeSecondEmpty(logger as Logger) as Boolean {
        var dict1 = { "level2" => { "key2" => 2, "key1" => 1 } };
        var dict2 = {};
        var expected = { "level2" => { "key2" => 2, "key1" => 1 } };
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        dumpMerged(dict1, dict2, logger);
        Test.assert(DictionaryUtilsBarrel.compareDictionaries(result, expected));
        return true;
    }

    (:test)
    function testMergeNull1(logger as Logger) as Boolean {
        var dict1 = {};
        var dict2 = null;
        var expected = {};
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        dumpMerged(dict1, dict2, logger);
        Test.assert(DictionaryUtilsBarrel.compareDictionaries(result, expected));
        return true;
    }

    (:test)
    function testMergeNull2(logger as Logger) as Boolean {
        var dict1 = null;
        var dict2 = {};
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        Test.assert(result == null);

        return true;
    }

    (:test)
    function testMergeNull3(logger as Logger) as Boolean {
        var dict1 = null;
        var dict2 = null;
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        Test.assert(result == null);
        return true;
    }

    (:test)
    function testMergeNull5(logger as Logger) as Boolean {
        var dict1 = { "level2" => { "key2" => 2, "key1" => 1 } };
        var dict2 = null;
        var expected = { "level2" => { "key2" => 2, "key1" => 1 } };
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        dumpMerged(dict1, dict2, logger);
        Test.assert(DictionaryUtilsBarrel.compareDictionaries(result, expected));
        return true;
    }
}
