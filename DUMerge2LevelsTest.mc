import Toybox.Lang;
import Toybox.System;
import Toybox.Test;

(:test)
module DictionaryUtilsBarrel {
    (:test)
    function testMerge2Levels1(logger as Logger) as Boolean {
        var dict1 = { "level2" => { "key1" => 1 } };
        var dict2 = { "level2" => { "key1" => 1 } };
        var expected = { "level2" => { "key1" => 1 } };
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        dumpMerged(dict1, dict2, logger);
        Test.assert(DictionaryUtilsBarrel.compareDictionaries(result, expected));
        return true;
    }

    (:test)
    function testMerge2Levels2(logger as Logger) as Boolean {
        var dict1 = { "level2" => { "key1" => 1, "key2" => 2 } };
        var dict2 = { "level2" => { "key2" => 2, "key1" => 1 } };
        var expected = dict1;
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        dumpMerged(dict1, dict2, logger);
        Test.assert(DictionaryUtilsBarrel.compareDictionaries(result, expected));
        return true;
    }

    (:test)
    function testMerge2Levels3(logger as Logger) as Boolean {
        var dict1 = { "level2" => { "key1" => 1, "key2" => 2 } };
        var dict2 = { "level2" => { "key1" => 1, "key2" => 2, "key3" => 3 } };
        var expected = dict2;
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        dumpMerged(dict1, dict2, logger);
        Test.assert(DictionaryUtilsBarrel.compareDictionaries(result, expected));
        return true;
    }

    (:test)
    function testMergeSingleKeyDifferentValue(logger as Logger) as Boolean {
        var dict1 = { "key1" => 1 };
        var dict2 = { "key1" => 2 };
        var expected = dict2;
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        dumpMerged(dict1, dict2, logger);
        Test.assert(DictionaryUtilsBarrel.compareDictionaries(result, expected));
        return true;
    }

    (:test)
    function testMergeReplaceDict1(logger as Logger) as Boolean {
        var dict1 = { "level2" => { "key1" => 1, "dict" => { "key2" => 2 } } };
        var dict2 = { "level2" => { "dict" => 7 } };
        var expected = { "level2" => { "key1" => 1, "dict" => 7 } };
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        dumpMerged(dict1, dict2, logger);
        Test.assert(DictionaryUtilsBarrel.compareDictionaries(result, expected));
        return true;
    }
}
