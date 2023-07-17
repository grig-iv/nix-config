function fish_prompt
    set_color -o 0e7970
    echo -n '['
    set_color normal
    set_color f3fffe
    echo -n (whoami)
    echo -n ' '
    set_color -o e3743c
    echo -n (prompt_pwd)
    set_color 0e7970
    echo -n '] '
    set_color red
    echo -n 'ඞ '
    set_color normal
end

