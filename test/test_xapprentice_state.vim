" State verification tests for setswitch.vim.

func TearDown()
    " Runs garbage collection after every test.
    call test_garbagecollect_now()
endfunc
