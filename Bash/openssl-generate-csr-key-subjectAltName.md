# Overview

This one line `openssl` command allows you to:
- generate a CSR (Certificate Signing Request). This is what you use to specify the parameters of your certificate you want to generate
- certificate generated will be `rsa:2048` type
- generate the private/secret key (it's a private key you use to encrypt your public certificate. **Save this key like your life depended on it! Maybe your job at the least...**)
- allows you to use an Alternative DNS name (`subjectAltName=DNS.1`) other than your main DNS name (a.k.a. `CN=` name)

## openssl one liner

`openssl req -new -newkey rsa:2048 -nodes -out <your-fully-qualified-url>.csr -keyout <your-fully-qualified-url>.key -subj "/C=<your-country-code>/ST=<your-state-or-province>/L=<your-city-or-town>/O=<your-company-name>/OU=<your-team-name>/CN=<your-fully-qualified-url>/emailAddress=<your-email-address>/subjectAltName=DNS.1=<your-alternative-url-that-will-be-valid>"`
