iabbrev <buffer> errreturn if err != nil {<cr>return nil, err<cr>}
iabbrev <buffer> errlog if err != nil {<cr>log.Println(err)<cr>return nil, err<cr>}
iabbrev <buffer> errfatal if err != nil {<cr>log.Fatalln(err)<cr>}
