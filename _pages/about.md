---
permalink: /about/
title: "About"
---

This little blog of mine serves my need to produce some notes in
a form that can also be shared with people who may be interested, in an attempt
to give back to the internet community.

Please note that I value copyright: anything I share here is original material
protected by the Creative Commons license (see below). If you feel this is not
the case or you want to use the material on this site please contact me.

## Contact information / Impressum

Marco Cosentino \\
Spechtstr. 9 \\
63263 Neu-Isenburg \\
GERMANY

E-mail: cosentino.ma at gmail.com

## Cookie policy and personal information

This site uses Google Analytics to track usage in a completely anonymous way.
IP addresses are also obfuscated and I don't collect any sort of user i
dentifier or [PII](https://en.wikipedia.org/wiki/Personal_data) 
which could be associated to individual users.

No cookies will be used if you disagree from the pop-up bar shown when you 
come to the site the first time. In such a case, Google Analytics is also 
disabled and np information will be collected about the visit.

Users who agreed to cookies usage can 
<a href="#" onclick="document.cookie='cookiebar=;expires=Thu, 01 Jan 1970 00:00:01 GMT;path=/'; setupCookieBar(); return false;">opt out</a>
from every page using the provided link in  the footer. In such a case cookies 
will be cleared and the next visit will be completely anonymous.

More about Google Analytics cookies [here](https://developers.google.com/analytics/devguides/collection/analyticsjs/cookies-user-id)

### Technical

I use [Cookie Bar](https://cookie-bar.eu/) to gather cookie consent. I use the following snippet to 
turn on / off Google Analytics and clear cookies in case of opt out:
```js
    window.ga = window.ga || function () { (ga.q = ga.q || []).push(arguments) }; ga.l = +new Date;
    let matches = document.cookie.match(/(;)?cookiebar=([^;]*);?/);
    let cookieValue = Array.isArray(matches) ? matches[2] : '';
    if (cookieValue == 'CookieAllowed') {
        ga('create', 'UA-141297186-1', 'auto');
        ga('set', 'allowAdFeatures', false);
        ga('set', 'anonymizeIp', true);
        ga('send', 'pageview');
    } else {
        ga('remove', 'UA-141297186-1')
        document.cookie.split(";").forEach(function (c) { 
            document.cookie = c.replace(/^ +/, "")
                .replace(/=.*/, "=;expires=" + new Date().toUTCString() + ";path=/"); 
        });
    }
```

Please let me know if this is somewhat incorrect. I tested it locally on my browser and it worked fine.

## License

cosenmarco's notes by Marco Cosentino is licensed under the
[Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

## Disclaimer

### No liability for any errors or omissions
The information contained in this Website has been provided by me for information purposes only.  This information does not constitute legal, professional or commercial advice.  While every care has been taken to ensure that the content is useful and accurate, I give no guarantees, undertakings or warranties in this regard, and does not accept any legal liability or responsibility for the content or the accuracy of the information so provided, or, for any loss or damage caused arising directly or indirectly in connection with reliance on the use of such information.  Any errors or omissions brought to my attention will be corrected as soon as possible.

The information in this website may contain technical inaccuracies and typographical errors.  The information in this website may be updated from time to time and may at times be out of date.  I accept no responsibility for keeping the information in this website up to date or any liability whatsoever for any failure to do so.


### Material on this website does not constitute legal and/or professional advice

Any views, opinions and guidance set out in this website are provided for information purposes only, and do not purport to be legal and/or professional advice.  Anyone contemplating action in respect of matters set out in this website should obtain advice from a suitably qualified professional adviser based on their unique requirements.


### Third Party Company and Products (Real and Fictitious)

Any reference or mention to third party companies and/or products on this website, is for purely informational purposes only.  This information does not constitute either an endorsement or a recommendation.  Unless clearly stated otherwise, all third party products and/or services must be ordered directly from the vendor and all licenses and warranties take place between you and the vendor.  I accept no liability whatsoever for the use or misuse of any third party companies and their products and/or services.


### Disclaimer for External Links

All addresses of, or links to, external websites contained on this website are provided
strictly for the convenience of the user. I am not responsible or liable for the content of any
external page which is referenced or linked by this website. The user assumes all risk of
injury. Such external websites contain information created, published, maintained, or otherwise
posted by institutions or organizations independent from me. Links from this website to
external sites do not constitute endorsement, approval, certification or control of these external
websites by me and do not guarantee the accuracy, completeness, efficacy, or timeliness of
information located at such websites. Therefore, I do not assume any liability for the
currency, accuracy, or availability of any information on external websites. Use of any
information obtained from external websites is voluntary, and reliance on such information
should only be undertaken after an independent review by qualified experts. Any concerns
regarding any external link should be directed to its site administrator or webmaster. Upon
following one of these links, the policies of that external site take effect until user returns to
this site.