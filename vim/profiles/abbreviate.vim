" Abbreviation

" The following items should be handled by snippet.
""" " for C
""" abbreviate #d #define
""" abbreviate #i #include
""" abbreviate intmain int<CR>main( int argc, char *argv[] )<CR>{<CR>return 0;<CR>}
"""
""" " for Perl
""" abbreviate #p #!/usr/bin/perl
""" let g:Perl_MapLeader  = ','     " perl-support のLeaderを変更する。 (VCSと競合したため)
"""
""" " for Python
""" abbreviate #y #!/usr/bin/env python
"""
""" " for bash
""" let g:BASH_MapLeader  = ','

