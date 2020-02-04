# CrowdFund Rails
A rails port of the existing AdoptTogether web app. AdoptTogether is a platform for Crowdfunded adoptions.

## Development

### Setup

1. Get the code

    ```shell
    % git clone git@github.com:carterdea/adopttogether.git
    ```

1. Install Dependencies
  * Ruby 2.3.1
  * Postgres
  * ImageMagick
  * ElasticSearch
  * Bower

1. Install Gems

    ```shell
    % bundle install
    ```

1. Install Front-end Dependencies

    ```shell
    % bower install
    ```

1. Setup the DB

    ```shell
    % rake db:setup:populate
    ```

1. Start the Server

    ```shell
    % foreman start -f Procfile.dev
    ```
    visit [http://locahlhost:5000](http://localhost:5000)

### Continuous Integration
Travis autodeploys to Heroku when a build passes on `Master`.

CodeClimate is making sure I'm not writing bad code and to keep my test coverage at a reasonable level.

### Stripe
Stripe is set up for single donations & recurring payments. Both allow the user to choose a custom amount.

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

### Testing
We use Rspec & Capybara for testing. You can run specs w/ the command:

```shell
% rspec
```

### Services
- Heroku
- Bonsai.io (for Elasticsearch)
- Mandrill (for Email)
- Code Climate
- Travis-CI
- AWS S3

### Browser Support
Last 2 version of:
- Chrome
- Safari
- Firefox
- IE 10+ & Edge


### Code Status
[![Code Climate](https://codeclimate.com/github/carterdea/adopttogether/badges/gpa.svg)](https://codeclimate.com/github/carterdea/adopttogether) [![Test Coverage](https://codeclimate.com/github/carterdea/adopttogether/badges/coverage.svg)](https://codeclimate.com/github/carterdea/adopttogether/coverage) [![Build Status](https://travis-ci.org/carterdea/adopttogether.svg?branch=master)](https://travis-ci.org/carterdea/adopttogether)

## Admin Access
Ask @carterdea (me@carterdea.com) for admin access


Credits
-------
- [@carterdea](https://github.com/carterdea)
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
