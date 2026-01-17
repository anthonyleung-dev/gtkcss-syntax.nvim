# gtkcss-syntax.nvim

GTK CSS syntax support for Neovim. Provides syntax highlighting for GTK3/GTK4 CSS files with `@define-color` support.

## Features

- Syntax highlighting based on CSS with GTK-specific additions
- `@define-color name #hex;` color definitions
- `@colorname` color variable references
- GTK functions: `alpha()`, `shade()`, `mix()`, `lighter()`, `darker()`
- `-gtk-*` properties
- `@import` and `@keyframes` support
- GTK widget selectors
- Proper comment and indentation settings
- **Header detection** for regular CSS files

## File Detection

### By Extension

- `*.gtk.css`
- `*.gtk.scss`
- `*.gtk.less`

### By Header

Any `.css`, `.scss`, or `.less` file with a header marker in the first 5 lines:

```css
/* gtk-css */
/* gtkcss */
/* gtk css */
```

Or files starting with `@define-color`:

```css
@define-color primary #ff0000;
```

## Installation

### lazy.nvim

```lua
{
    "anthonyleung-dev/gtkcss-syntax.nvim",
    ft = "gtkcss",
    config = function()
        require("gtkcss").setup()
    end,
}
```

### Local installation

```lua
{
    dir = "~/projects/gtkcss.nvim",
    ft = "gtkcss",
    config = function()
        require("gtkcss").setup()
    end,
}
```

## Configuration

```lua
require("gtkcss").setup({
    -- File extensions to detect as gtkcss (default)
    extensions = { "gtk.css", "gtk.scss", "gtk.less" },
    -- Additional filename patterns (lua patterns)
    patterns = {},
    -- Header markers to detect gtkcss in css files
    headers = { "gtk-css", "gtkcss", "gtk css" },
})
```

### Custom Extensions

```lua
require("gtkcss").setup({
    extensions = {
        "gtk.css",
        "gtk.scss",
        "gtk.less",
        "gtk.sass",
    },
})
```

### Custom Headers

```lua
require("gtkcss").setup({
    headers = {
        "gtk-css",
        "gtkcss",
        "waybar",  -- detect waybar css files
    },
})
```

## Usage

### Option 1: Use `.gtk.css` extension

```
styles/
├── color.gtk.css
├── theme.gtk.css
└── main.gtk.css
```

### Option 2: Add header to regular CSS file

```css
/* gtk-css */

@define-color primary #ff0000;

* {
  color: @primary;
}
```

## Syntax Highlighting

| Element                  | Highlight Group |
| ------------------------ | --------------- |
| `@define-color`          | PreProc         |
| Color names              | Identifier      |
| Color values (#hex)      | Constant        |
| Color references (@name) | Special         |
| GTK functions            | Function        |
| `-gtk-*` properties      | Statement       |
| `@import`                | PreProc         |
| `@keyframes`             | PreProc         |
| Widget selectors         | Type            |

## License

MIT
