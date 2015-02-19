# MultipeerDemo

This project demonstrates the capability of the Multipeer Connectivity framework. Over multiple devices, you can share a video file, a photo file, and a JSON document.

Note: For best results in timing, send each file twice - the second time directly after the first has been received. There is no way to time when a share has been initiated from a separate device using ```NSData``` objects, so this is the best way to do so.
