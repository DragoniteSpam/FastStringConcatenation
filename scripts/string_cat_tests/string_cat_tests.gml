#macro CAT_TRIAL_COUNT 100
#macro CAT_CONCAT_COUNT 1000

var trial2 = function(str1, str2) {
    var t = get_timer();
    var result;
    
    repeat (CAT_TRIAL_COUNT) {
        result = "";
        repeat (CAT_CONCAT_COUNT) {
            result = result + str1 + str2;
        }
    }
    
    show_debug_message("Normal concatenating 2 words x " + string(CAT_CONCAT_COUNT) + "@" + string(CAT_TRIAL_COUNT) + " took " + string((get_timer() - t) / 1000) + " ms")
    
    t = get_timer();
    
    repeat (CAT_TRIAL_COUNT) {
        result = "";
        repeat (CAT_CONCAT_COUNT) {
            result = string_cat_fast(result, str1, str2);
        }
    }
    
    show_debug_message("Fast concatenating 2 words x " + string(CAT_CONCAT_COUNT) + "@" + string(CAT_TRIAL_COUNT) + " took " + string((get_timer() - t) / 1000) + " ms")
}

var trial3 = function(str1, str2, str3) {
    var t = get_timer();
    var result;
    
    repeat (CAT_TRIAL_COUNT) {
        result = "";
        repeat (CAT_CONCAT_COUNT) {
            result = result + str1 + str2 + str3;
        }
    }
    
    show_debug_message("Normal concatenating 3 words x " + string(CAT_CONCAT_COUNT) + "@" + string(CAT_TRIAL_COUNT) + " took " + string((get_timer() - t) / 1000) + " ms")
    
    t = get_timer();
    
    repeat (CAT_TRIAL_COUNT) {
        result = "";
        repeat (CAT_CONCAT_COUNT) {
            result = string_cat_fast(result, str1, str2, str3);
        }
    }
    
    show_debug_message("Fast concatenating 3 words x " + string(CAT_CONCAT_COUNT) + "@" + string(CAT_TRIAL_COUNT) + " took " + string((get_timer() - t) / 1000) + " ms")
}

var trial7 = function(str1, str2, str3, str4, str5, str6, str7) {
    var t = get_timer();
    var result;
    
    repeat (CAT_TRIAL_COUNT) {
        result = "";
        repeat (CAT_CONCAT_COUNT) {
            result = result + str1 + str2 + str3 + str4 + str5 + str6 + str7;
        }
    }
    
    show_debug_message("Normal concatenating 7 words x " + string(CAT_CONCAT_COUNT) + "@" + string(CAT_TRIAL_COUNT) + " took " + string((get_timer() - t) / 1000) + " ms")
    
    t = get_timer();
    
    repeat (CAT_TRIAL_COUNT) {
        result = "";
        repeat (CAT_CONCAT_COUNT) {
            result = string_cat_fast(result, str1, str2, str3, str4, str5, str6, str7);
        }
    }
    
    show_debug_message("Fast concatenating 7 words x " + string(CAT_CONCAT_COUNT) + "@" + string(CAT_TRIAL_COUNT) + " took " + string((get_timer() - t) / 1000) + " ms")
}

trial2("Hello", " World");
trial3("I", " like", "pi[e]");
trial7("She", " sells", " sea", " shells", " by", " the", " seashore");

show_debug_message("----------");

#macro BUILDER_TRIAL_COUNT 10
#macro BUILDER_CONCAT_COUNT 10000

var builder = new StringBuilder("She").Append("Sells").Append("Seashells").Append("By").Append("The").Append("Seashore");
show_debug_message(builder);
builder.Clear().Append("The").Append(" cake").Append(" is").Append(" a").Append(" lie");
show_debug_message(builder);

var builder_trial = function(str) {
    var t = get_timer();
    var result;
    
    repeat (BUILDER_TRIAL_COUNT) {
        result = "";
        repeat (BUILDER_CONCAT_COUNT) {
            result = result + str;
        }
    }
    
    show_debug_message("Building a string the slow way x " + string(BUILDER_CONCAT_COUNT) + "@" + string(BUILDER_TRIAL_COUNT) + " took " + string((get_timer() - t) / 1000) + " ms")
    
    t = get_timer();
    
    var builder = new StringBuilder();
    
    repeat (CAT_TRIAL_COUNT) {
        builder.Clear();
        repeat (CAT_CONCAT_COUNT) {
            builder.Append(str);
        }
    }
    
    show_debug_message("Building a string the fast way x " + string(BUILDER_CONCAT_COUNT) + "@" + string(BUILDER_TRIAL_COUNT) + " took " + string((get_timer() - t) / 1000) + " ms")
}

builder_trial("Meow");