# in my words

"in my words" is a Chrome extension. It allows you to define a dictionary of words to be dynamically overwritten as you read the web.

A trivial example: say you hate when folks misspell "definitely" as "definately". With this extension, you could ensure that you'll never have to see the typo on the web again!

## installing the plugin

You can install the plugin yourself [at the Chrome Web Store](https://chrome.google.com/webstore/detail/ifallpipodahhpbnemkhiddofdkhlekg)
.
Of course, you can also do things the hard way:

1. Clone this repo,
2. Navigate to [chrome://extensions](chrome://extensions)
3. Click "Load Unpacked Extension"
4. Choose this repository's `public` directory

The app is configured from its Options page, a link to which can be found on Chrome's extension settings tab.

## tests

This extension was developed using test-driven design, facilitated by isolation tests written with Jasmine. If you're interested in checking out the specs, I'd strongly encourage cloning the repo.

If you would like to run the tests, I'd recommend using [jasmine-headless-webkit](http://johnbintz.github.com/jasmine-headless-webkit/).

If you've never installed jasmine-headless-webkit, you'll need to install the qt library first (as it provides a WebKit widget that can be invoked headlessly). The easiest way to install qt is to run Mac OS X and [homebrew](https://github.com/mxcl/homebrew). If you have homebrew available, you can install qt like this:

``` bash
$ brew install qt --build-from-source
```

Once qt is installed, you should be able to run the tests like so:

``` bash
$ gem install bundler
$ bundle
$ bundle exec jasmine-headless-webkit
```

But it's more fun to run the tests continuously; they'll execute each time a file changes if you invoke them via [guard](https://github.com/guard/guard):

``` bash
$ bundle exec guard -g j
```

## compiling the assets

If you change any of the CoffeeScript files and you want to see your changes in the browser, you'll need to recompile the assets (which are compiled to `public/assets/application.js`). You can do that by running guard with:

``` bash
$ bundle exec guard -g a
```