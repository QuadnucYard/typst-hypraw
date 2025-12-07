def main [] {
    for file in (ls examples) {
        if ($file.name | path parse | get extension) == "typ" {
            typst c $file.name --format html --features html --root .
        }
    }
}
