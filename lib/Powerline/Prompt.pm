use v6;

use Powerline::Prompt::Segment;
use Powerline::Prompt::Segment::Git;

role Powerline::Prompt {

    has Str $.user;
    has Str $.host;
    has Str $.root;
    has Str $.path = '.';
    has Int $.exit = 0;
    has Str $.separator = '';

    method draw {
        my @segments;

        # Username
        @segments.push( Powerline::Prompt::Segment.new(text => $.user, foreground => 250, background => 240) );

        # Hostname
        @segments.push( Powerline::Prompt::Segment.new(text => $.host, foreground => 250, background => 238) );

        # Git
        @segments.push( Powerline::Prompt::Segment::Git.new(cwd => $.path) );

        # Root
        @segments.push( Powerline::Prompt::Segment.new(text => $.root, foreground => 15, background =>  236) );

        my Str $prompt = '';
        while my $segment = @segments.shift {
            next if $segment.text.chars == 0;           # skip empty segments

            my $next = @segments[0];
            while ($next && $next.text.chars == 0) {    # find next non empty segment
                @segments.shift;
                $next = @segments[0];
            }

            $prompt ~= sprintf(
                '\[\e[38;5;' ~ $segment.foreground ~ 'm\]\[\e[48;5;' ~ $segment.background ~ 'm\]' ~
                $segment.text ~
                ( $next
                    ?? '\[\e[38;5;' ~ $segment.background ~ 'm\]\[\e[48;5;' ~ $next.background ~ 'm\]'
                    !! '\[\e[0m\]' ~ '\[\e[38;5;' ~ $segment.background ~ 'm\]'
                ) ~ $.separator ~ '\[\e[0m\]');
        }

        $prompt;
    }

}
