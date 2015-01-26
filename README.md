# vim-eastwood


vim-eastwood is a vim plugin for [Eastwood](https://github.com/jonase/eastwood/), the Clojure lint tool. It extends [Syntastic](https://github.com/scrooloose/syntastic)'s checkers, so you'll see those familiar markers in your UI:

![](doc/demo.png)

## Installation

### Requirements

You'll need to have both [Eastwood](https://github.com/jonase/eastwood/) and [fireplace](https://github.com/tpope/vim-fireplace/) installed, and you'll need Eastwood to be somewhere on the Leiningen classpath. In order for Syntastic to actually try to lint the file you're working on, you'll also need to have an actual REPL connection open through fireplace as well. The rest should take care of itself.

### Installing vim-eastwood with Pathogen

Assuming you already have [Pathogen](https://github.com/tpope/vim-pathogen) installed, you should be good to go with the following:

```
cd ~/.vim/bundle && \
git clone https://github.com/scrooloose/syntasÂtic.git
```

For Vundle you just need to make sure you have the following 2 lines in your .vimrc:

Bundle 'scrooloose/syntastic'
Bundle 'dbakker/vim-lint'

## License

Copyright (c) Daan Bakker.

Licensed under the Eclipse Public License, the same as Clojure.
