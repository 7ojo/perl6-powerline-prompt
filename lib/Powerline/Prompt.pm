use v6;

use Git::Simple;
use Powerline::Prompt::Segment;

role Powerline::Prompt {

    method draw {
        my @segments;

        # Username
        @segments.push( Powerline::Prompt::Segment.new(text => $.user, foreground => 250, background => 240) );

        # Hostname
        @segments.push( Powerline::Prompt::Segment.new(text => $.host, foreground => 250, background => 238) );

        # Git
        my %branch-info = Git::Simple.new.branch-info;
        @segments.push( Powerline::Prompt::Segment.new(text => " {%branch-info<local>.Str} ", foreground => 0, background => 148) ) if %branch-info.elems > 0;

        # Root
        @segments.push( Powerline::Prompt::Segment.new(text => $.root, foreground => 15, background =>  236) );

        my Str $prompt = '';
        while my $segment = @segments.shift {
            my $next = @segments[0];
            $prompt ~= sprintf(
                '\[\e[38;5;' ~ $segment.foreground ~ 'm\]\[\e[48;5;' ~ $segment.background ~ 'm\]' ~
                $segment.text ~
                ( $next
                    ?? '\[\e[38;5;' ~ $segment.background ~ 'm\]\[\e[48;5;' ~ $next.background ~ 'm\]'
                    !! '\[\e[0m\]' ~ '\[\e[38;5;' ~ $segment.background ~ 'm\]'
                ) ~ '' ~ '\[\e[0m\]');
        }

        $prompt;
    }

}
