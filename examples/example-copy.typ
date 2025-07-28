#import "/src/lib.typ": *

#show: hypraw

= Hypraw Example (With Copy Buttons)

This demonstrates basic usage of hypraw with copy buttons enabled (default behavior).

```typ
#show: hypraw.with(copy-button: true)
```

== Copy Button Feature

All code blocks above include copy buttons (📋) that allow one-click copying of the code content. The buttons are headless and fully customizable via CSS.

#let style = ```css
/* Copy button styles */
.hypraw-copy-btn {
  position: absolute;
  top: 0.5em;
  right: 0.5em;
  background: var(--hypraw-copy-btn-bg);
  border: 1px solid transparent;
  border-radius: 0.25em;
  padding: 0.25em 0.5em;
  font-size: 0.875em;
  cursor: pointer;
  transition: all 0.2s ease;
  z-index: 1;
}

.hypraw-copy-btn::before {
  content: "📋";
  font-size: 1rem;
}

.hypraw-copy-btn:hover {
  background: var(--hypraw-copy-btn-hover-bg);
  border-color: hsla(0, 0%, 70%, 1);
}

.hypraw-copy-btn:active {
  background: var(--hypraw-copy-btn-active-bg);
  transform: translateY(1px);
}

/* Success state */
.hypraw-copy-btn.copied {
  background: hsla(120, 40%, 85%, 1);
  border-color: hsla(120, 40%, 70%, 1);
}

.hypraw-copy-btn.copied::after {
  content: " ✓";
  color: hsla(120, 60%, 40%, 1);
}
```
#style

#html-script(read("copy-to-clipboard.js"))
#html-style(read("example.css") + style.text)

