# Setup Instructions

This document explains the main setup needed prior to the workshop. 

You will need the following SuperCollider extensions:

- Freesound.quark
- MIRLC
- MILRC 2.0
- flucoma
- MIRLCa


## Step 1

If you don't have SuperCollider installed in your computer, please make sure to first install SuperCollider. You can download it from: 

[https://supercollider.github.io/download](https://supercollider.github.io/download)

**For Mac users**: both signed/notarized and not signed/notarized versions of SuperCollider should work, but we recommend the not-signed/not-notarized version for a less disruptive experience.


## Step 2

**For Windows users**: `curl` should be installed in your computer so that Freesound.quark and the related extensions work. 

You can check whether you have `curl` installed by opening the command prompt.

If you don't know how to open the command prompt in Windows, here's a link that explains how to do it:

[https://www.ionos.co.uk/digitalguide/server/tools/open-command-prompt/](https://www.ionos.co.uk/digitalguide/server/tools/open-command-prompt/)

Once you have the command prompt open, type the following:

`curl -help`

If a help file is displayed, this means that curl is installed. If it is not installed, you will need to install it. 

## Step 3

Install the extensions provided in this folder at the "Extensions" folder of SuperCollider. 

If you are unsure where is this folder, open SuperCollider and type:

`Platform.userExtensionDir;`  // Extensions available only to your user account

Then click `cmd+Enter` to find out where is the user extension directory in your computer.

In Mac, the user extension library is located inside `"~/Library"`. If you cannot find this folder, here's a link that explains how to find it:

[https://www.macrumors.com/how-to/reveal-library-folder-in-macos/](https://www.macrumors.com/how-to/reveal-library-folder-in-macos/)

## Step 4

In order to include the extensions in SuperCollider, you will need to recompile the class library. For that, click on the option "Language" at the top menu and select "Recompile Class Library".

## Step 5

Please refer to the tutorials of the workshop to investigate how each of the extensions work. Happy coding!

