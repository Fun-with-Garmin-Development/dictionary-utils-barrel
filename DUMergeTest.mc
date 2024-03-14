import Toybox.Lang;
import Toybox.System;
import Toybox.Test;

(:test)
module DictionaryUtilsBarrel {
    (:test)
    function testMergeNonOverlaping(logger as Logger) as Boolean {
        var dict1 = { "a" => 1, "b" => 2, "c" => 3 };
        var dict2 = { "d" => 4, "e" => 5, "f" => 6 };
        var expected = { "a" => 1, "b" => 2, "c" => 3, "d" => 4, "e" => 5, "f" => 6 };
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        dumpMerged(dict1, dict2, logger);
        Test.assert(DictionaryUtilsBarrel.compareDictionaries(result, expected));
        return true;
    }

    (:test)
    function testMergeReplaceOne(logger as Logger) as Boolean {
        var dict1 = { "a" => 1, "b" => { "k1" => "v1", "k2" => "v2" } };
        var dict2 = { "b" => { "k2" => "v3" } };
        var expected = { "a" => 1, "b" => { "k1" => "v1", "k2" => "v3" } };
        var result = DictionaryUtilsBarrel.mergeDictionaries(dict1, dict2);
        dumpMerged(dict1, dict2, logger);
        Test.assert(DictionaryUtilsBarrel.compareDictionaries(result, expected));
        return true;
    }
}
