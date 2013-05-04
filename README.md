# Project Description
An optimized implementation of the JPEG-LS standard for lossless and near-lossless image compression. JPEG-LS is a low-complexity standard that matches JPEG 2000 compression ratios. In terms of speed, CharLS outperforms open source and commercial JPEG LS implementations. 

## About this software
This project's goal is to provide a full implementation of JPEG-LS. This library is written from scratch in portable C++. All mainstream JPEG-LS features are implemented by this library. 
According to preliminary test results published on imagecompression.info/gralic, CharLS is about twice as fast as the original HP code, and beats both JPEG-XR and JPEG 2000 by a factor 3. 

## About JPEG-LS
JPEG-LS (ISO-14495-1/ITU-T.87) is a standard derived from the Hewlett Packard LOCO algorithm. JPEG LS has low complexity (meaning fast compression) and high compression ratios, similar to JPEG 2000. JPEG-LS is more similar to the old Lossless JPEG than to JPEG 2000, but interestingly the two different techniques result in vastly different performance characteristics. 
Wikipedia on lossless JPEG and JPEG-LS: http://en.wikipedia.org/wiki/Lossless_JPEG
Benchmarks: JPEG-LS-Performance

# Building & Using
* The library is built using CMake.
* It comes with a _FindCharLS.cmake_ macro which allows convenient integration into other CMake-based projects

# Legal
The code in this project is available through a BSD style license, allowing use of the code in commercial closed source applications if you wish. All the code in this project is written from scratch, and not based on other JPEG-LS implementations. Be aware that Hewlett Packard claims to own patents that apply to JPEG-LS implementations, but they license it for free for conformant JPEG-LS implementations. Read more at http://www.hpl.hp.com/loco/ before you use this if you use this code for commercial purposes. 
