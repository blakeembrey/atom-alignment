# Atom Alignment

[![Greenkeeper badge](https://badges.greenkeeper.io/blakeembrey/atom-alignment.svg)](https://greenkeeper.io/)

[![Build status][travis-image]][travis-url]

Quick alignment of multi-line selections and multiple selections for [Atom](https://atom.io/packages/alignment).

## Installation

```
apm install alignment
```

## Usage

Make a selection of the lines to you want to align and press `cmd-ctrl-alt-]`/`cmd-ctrl-a` (or `ctrl-alt-]`/`ctrl-alt-a` on Windows and Linux). It will transform something like:

```js
var test = 'string';
var another = 10;
var small = 10 * 10;
```

Into:

```js
var test    = 'string';
var another = 10;
var small   = 10 * 10;
```

## License

MIT

[travis-image]: https://img.shields.io/travis/blakeembrey/atom-alignment.svg?style=flat
[travis-url]: https://travis-ci.org/blakeembrey/atom-alignment
