import Toybox.Lang;
import Toybox.System;

module DictionaryUtilsBarrel {

    public function compareDictionaries(dict1 as Dictionary?, dict2 as Dictionary?) as Boolean {
        if (dict1 == null && dict2 == null) {
            return true;
        } else if (dict1 == null || dict2 == null) {
            return false;
        }

        var keys1 = dict1.keys();
        var keys2 = dict2.keys();

        if (keys1.size() != keys2.size()) {
            return false;
        }

        for (var i = 0; i < keys1.size(); i++) {
            var key = keys1[i];
            if (!dict2.hasKey(key)) {
                return false;
            }
            var value1 = dict1[key];
            var value2 = dict2[key];
    
            if (value1 instanceof Dictionary) {
                if (value2 instanceof Dictionary) {
                    if (!compareDictionaries(value1, value2)) {
                        return false;
                    }
                } else {
                    return false;
                }
            } else if (value1 != value2) {
                return false;
            }
        }

        return true;
    }

    function mergeDictionaries(dict1 as Dictionary?, dict2 as Dictionary?) as Dictionary? {
        // if dict2 is null, return dict1; don't proceed with dict1 if it is null
        if (dict1 == null || dict2 == null) {
            return dict1;
        }
        var keys = dict2.keys();
        for (var i = 0; i < keys.size(); i++) {
            var key = keys[i];
            var value = dict2[key];
            if (value instanceof Dictionary && dict1[key] instanceof Dictionary) {
                dict1[key] = mergeDictionaries(dict1[key], value);
            } else {
                dict1[key] = value;
            }
        }
        return dict1;
    }
}
