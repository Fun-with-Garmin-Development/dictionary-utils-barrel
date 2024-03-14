import Toybox.Lang;
import Toybox.System;
import Toybox.Test;

module DictionaryUtilsBarrel {
    (:test)
    function testBothEmpty(logger as Logger) as Boolean {
        var dict1 = {};
        var dict2 = {};
        var comparison = DictionaryUtilsBarrel.compareDictionaries(dict1, dict2);
        Test.assert(comparison);

        return true;
    }

    (:test)
    function testFirstEmpty(logger as Logger) as Boolean {
        var dict1 = {};
        var dict2 = { "level2" => { "key2" => 2, "key1" => 1 } };
        var comparison = DictionaryUtilsBarrel.compareDictionaries(dict1, dict2);
        Test.assert(!comparison);

        return true;
    }

    (:test)
    function testSecondEmpty(logger as Logger) as Boolean {
        var dict1 = { "level2" => { "key2" => 2, "key1" => 1 } };
        var dict2 = {};
        var comparison = DictionaryUtilsBarrel.compareDictionaries(dict1, dict2);
        Test.assert(!comparison);

        return true;
    }

    (:test)
    function testNull1(logger as Logger) as Boolean {
        var dict1 = {};
        var dict2 = null;
        var comparison = DictionaryUtilsBarrel.compareDictionaries(dict1, dict2);
        Test.assert(!comparison);

        return true;
    }

    (:test)
    function testNull2(logger as Logger) as Boolean {
        var dict1 = null;
        var dict2 = {};
        var comparison = DictionaryUtilsBarrel.compareDictionaries(dict1, dict2);
        Test.assert(!comparison);

        return true;
    }

    (:test)
    function testNull3(logger as Logger) as Boolean {
        var dict1 = null;
        var dict2 = null;
        var comparison = DictionaryUtilsBarrel.compareDictionaries(dict1, dict2);
        Test.assert(comparison);

        return true;
    }

    (:test)
    function testNull5(logger as Logger) as Boolean {
        var dict1 = { "level2" => { "key2" => 2, "key1" => 1 } };
        var dict2 = null;
        var comparison = DictionaryUtilsBarrel.compareDictionaries(dict1, dict2);
        Test.assert(!comparison);

        return true;
    }
}
