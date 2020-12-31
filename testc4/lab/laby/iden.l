%{
    #include "iden.tab.h"
%}

%%

[a-zA-Z]    return LETTER;
"_"         return UNDERSCORE;
[0-9]       return DIGIT;
" "         return SPACE;
.|\n  ;


%%

int yywrap() { return 1; }
