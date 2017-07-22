# trolMail

R package to send an useless e-mail

To install, run:
 ```R
if (!require(devtools)) {
  install.packages('devtools')
}
devtools::install_github('Emelieh21/trolMail')
 ```


This package only includes one function `trolmail()` , which generates an email with a random giphy gif and [compliment](http://toykeeper.net/programs/mad/compliments). For this the Giphy API is used and an API key is needed (can be requested [here](https://developers.giphy.com/)).

The function works as follows:

#### 1: Enter sender e-mail address & password

![image](/assets/screenshot1.png)

#### 2: Enter a topic & receiver(s) email address(es)

![image2](assets/screenshot2.png)

#### 3: Your email has been sent!

![image3](assets/screenshot3.png)