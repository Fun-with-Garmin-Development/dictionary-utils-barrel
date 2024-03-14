import Toybox.Lang;
import Toybox.System;
import Toybox.Test;

(:test)
module DictionaryUtilsBarrel {
    const QUIET = true;
    function dumpInfo(dict1 as Dictionary?, dict2 as Dictionary?, logger as Logger) {
        if (QUIET) {
            return;
        }
        logger.debug(Lang.format("dict1: $1$", [dict1]));
        logger.debug(Lang.format("dict2: $1$", [dict2]));
        if (dict1 != null) {
            logger.debug(Lang.format("dict1.equals(dict2): $1$", [dict1.equals(dict2)]));
        }
        if (dict1 != null && dict2 != null) {
            logger.debug(
                Lang.format("dict1.toString().equals(dict2.toString()): $1$", [
                    dict1.toString().equals(dict2.toString())
                ])
            );
            // compare hash codes
            logger.debug(Lang.format("dict1.hashCode(): $1$", [dict1.hashCode()]));
            logger.debug(Lang.format("dict2.hashCode(): $1$", [dict2.hashCode()]));
        }
    }
}
