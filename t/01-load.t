use v6;
use lib 'lib';
use Test;

plan 3;

use-ok 'Powerline::Prompt',                 'load Powerline::Prompt';
use-ok 'Powerline::Prompt::Segment',        'load Powerline::Prompt::Segment';
use-ok 'Powerline::Prompt::Shell::Bash',    'load Powerline::Prompt::Shell::Bash';