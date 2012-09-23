**ThinReports Example: EUDC**

---

# How to support the External-Character (外字)

## Example

### Files

* **eudc.tlf**  
  layout file for ThinReports
* **eudc.ttf**  
  external characters file (EUDC file)
* **sample_eudc.pdf**  
  result PDF

### How to run

Bundle:

    % bundle install

Then execute `eudc.rb`:

    % ruby eudc.rb

It will be created `eudc.pdf`.

### Requirements

* Ruby 1.8.7, 1.9.2, 1.9.3
* Runtime dependencies
  * Bundler
  * ThinReports 0.7.0+

## How to create EUDC.ttf

1. Windows の外字エディタで外字を作る
2. 作成された `EUDC.TTE` をコピー（Vista 以降は管理者権限必要）
3. 拡張子を `ttf` へ変更

## License, Copyright

See [this file](../README.md) .
