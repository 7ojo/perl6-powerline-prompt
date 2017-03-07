use v6;

class Powerline::Prompt::Segment {

    has Str $.text is rw = '';
    has Int $.foreground is rw;
    has Int $.background is rw;

}
