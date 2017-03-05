# Powerline::Prompt
[![Build Status](https://travis-ci.org/7ojo/perl6-powerline-prompt.svg?branch=master)](https://travis-ci.org/7ojo/perl6-powerline-prompt)

Make a useful prompt for your shell.

![Screenshot](https://raw.githubusercontent.com/7ojo/perl6-powerline-prompt/master/examples/powerline-prompt.png)

# SYNOPSIS

~/powerline-prompt.p6

    #!/usr/bin/env perl6

    use v6;
    use Powerline::Prompt::Shell::Bash;

    print Powerline::Prompt::Shell::Bash.new.draw;

# SETUP

## Bash

~/.bashrc

    function _update_ps1() {
        PS1="$(~/powerline-prompt.p6 $? 2> /dev/null)"
    }

    if [ "$TERM" != "linux" ]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi

