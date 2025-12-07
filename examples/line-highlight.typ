#import "/src/lib.typ": *

#show: hypraw.with(line-numbers: true, copy-button: false)

= Hypraw Line Highlight Example

Highlight specific lines (1-based indices):

#hypraw-set(highlight: (1, 3))
```js
console.log('Line 1 - highlighted');
console.log('Line 2 - normal');
console.log('Line 3 - highlighted');
```

Highlight ranges and individual lines:

#hypraw-set(highlight: (1, (3, 5)))
```js
console.log('Line 1 - highlighted');
console.log('Line 2 - normal');
console.log('Line 3 - highlighted');
console.log('Line 4 - highlighted');
console.log('Line 5 - highlighted');
```

Use different highlight styles (ins/del/mark):

#hypraw-set(highlight: (ins: (1, 2), del: (4,), mark: (6,)))
```js
console.log('Line 1 - inserted');
console.log('Line 2 - inserted');
console.log('Line 3 - normal');
console.log('Line 4 - deleted');
console.log('Line 5 - normal');
console.log('Line 6 - marked');
```

#html-style(read("base.css"))
#html-style(read("line-numbers.css"))
#html-style(read("line-highlight.css"))

