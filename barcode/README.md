**ThinReports Example: Barcode**

---

# How to display the BarCode

## Example

### Files

* **barcode.tlf** : The layout file for ThinReports
* **sample_barcode.pdf** : Result PDF file

### How to run

Bundle:

    % bundle install

Then execute `barcode.rb`:

    % bundle exec ruby barcode.rb

It will be created `barcode.pdf`.

### Requirements

* Ruby 1.8.7, 1.9.2, 1.9.3
* Runtime dependencies
  * Bundler
  * ThinReports 0.7.0+
  * Barby
  * rQRCode
  * ChunkyPNG

## License, Copyright

See [this file](https://github.com/thinreports/thinreports-examples/blob/master/README.md) .
