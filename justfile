set shell := ["nu", "-c"]

export TYPST_ROOT := justfile_directory()


default:
  @just --list

package target="out":
  nu scripts/package.nu {{target}}

build-readme:
  typlite README.typ README.md --assets-path assets
