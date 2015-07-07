# AdoptTogether.org
A rails port of the existing AdoptTogether web app.

## Development

### Setup

1. Get the code.
  
        % git clone git@github.com:carterdea/adopttogether.git

2. Install Dependencies
-- Ruby 2.2.2
-- ImageMagick
-- ElasticSearch

3. Install Gems

        % bundle install

4. Setup the DB

        % rake db:schema:load

5. Start ElasticSearch

        % elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml

6. Start the Server

        % rails s

visit http://locahlhost:3000

### Continuous Integration
TODO

### Stripe
TODO

#### Test Cards

<table>
  <thead>
    <tr>
      <th>Card</th>
      <th>Number</th>
      <th>Expiration</th>
      <th>CVV</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Visa</td>
      <td>4242424242424242</td>
      <td>Any future date</td>
      <td>Any 3 digits</td>
    </tr>
  </tbody>
</table>

### Services
- Heroku
- Travis-CI
- AWS S3

### Browser Support
Last 2 version of:
- Chrome
- Safari
- Firefox
- IE 9+


### Code Status
[![Code Climate](https://codeclimate.com/github/carterdea/adopttogether/badges/gpa.svg)](https://codeclimate.com/github/carterdea/adopttogether)
<!-- [![Test Coverage](https://codeclimate.com/github/carterdea/adopttogether/badges/coverage.svg)](https://codeclimate.com/github/carterdea/adopttogether/coverage) -->
[![Build Status](https://travis-ci.org/carterdea/adopttogether.svg?branch=master)](https://travis-ci.org/carterdea/adopttogether)

## Admin Access
TODO


Credits
-------
- [@carterdea](https://github.com/carterdea)
- [@jtribble](https://github.com/jtribble)
- [@alexwines224](https://github.com/Alexwines224)
- [@kurzee](https://github.com/kurzee)

License
-------

The MIT License (MIT)

Copyright (c) 2015 Carter De Angelis

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
