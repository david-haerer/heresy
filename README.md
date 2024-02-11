<h1 align="center"><img src="./heresy.svg" alt="heresy" /></h1>
<p align="center"><em>Building a relationship between iOS and Linux.</em><p>

## About

I have two devices with the following operating systems:

- **iPhone `SE 2020`** running **iOS `17.2.1`**
- **ThinkPad `T460`** running **Debian `12`**

This project is about building a relationship between the two.

## User Stories

- [ ] I want to copy music files from Linux to the iOS music library.
- [x] I want to copy songs from the iOS music library to Linux.
- [ ] I want to copy movies and TV series from the iOS TV library to Linux.
- [ ] I want to develop iOS apps on Linux.
- [ ] I want to deploy iOS apps from Linux to iOS.

## Can we follow the Debian Wiki?

The [iPhone](https://wiki.debian.org/iPhone) article in the Debian Wiki looks promising!
It makes use of the [`libimobiledevice`](https://libimobiledevice.org/) library.
However, their [FAQ](https://libimobiledevice.org/#faq) state:

> **How do I copy music to my device?**  
> Sorry, music synchronization with newer devices is currently not supported but if you are a keen developer why not contribute a new service implementation for the ATC Service?

But nonetheless, let's give it a try.

1. Install the necessary dependencies on the ThinkPad .
   ```sh
   sudo apt install ideviceinstaller python3-imobiledevice libimobiledevice-utils libimobiledevice6 libplist3 python3-plist ifuse usbmuxd libusbmuxd-tools
   ```
1. Create a directory for mounting the iPhone on the ThinkPad.
   - I'm going with `mkdir ~/iPhone`.
1. Connect the iPhone with the ThinkPad with the USB-Lightning cable.
1. Run `idevicepair pair`.
   - It will give an error message.
     ```
     ERROR: Could not validate with device XXXXXXXX-XXXXXXXXXXXXXXXX because a passcode is set. Please enter the passcode on the device and retry.
     ```
   - `XXX...` is the device serial number.
1. A dialog opens on the iPhone.
   > **Trust This Computer?**  
   > Your settings and data will be accessible from this computer when connected.  
   > Trust | **Don't Trust**
1. Tab **Trust** on the iPhone.
1. The iPhone prompts for the device code.
1. Enter the device code on the iPhone.
1. Run `idevicepair pair` again.
   - It should give a success message.
     ```
     SUCCESS: Paired with device XXXXXXXX-XXXXXXXXXXXXXXXX
     ```
   - `XXX...` is the device serial number.
1. Run `ifuse ~/iPhone`.
1. Run `ls ~/iPhone` to see the mounted content.
   ```
   Books        EnhancedAudioSharedKeys  MediaAnalysis  Podcasts
   CloudAssets  Espresso                 Music          PublicStaging
   DCIM         iTunes_Control           PhotoData      Purchases
   Downloads    ManagedPurchases         Photos         Radio
   ```
1. Run `ls ~/iPhone/Music` to see the content of the music folder.
   ```
   Cache  Downloads
   ```
1. Run `ls ~/iPhone/Music/Downloads` to see the content of the music downloads folder.
   - Among other files, it lists
     ```
     XXXXXXXXXXXXXXXXXX.m4a
     XXXXXXXXXXXXXXXXXXX.plist
     XXXXXXXXXXXXXXXXXXX.jpg
     StorePurchasesInfo.plist
     ```
   - `XXX...` are random looking numbers.
   - Run `cp ~/iPhone/Music/Downloads/XXXXXXXXXXXXXXXXXX.m4a ~/song.m4a` to copy the `.m4a` file.
   - Run `mpv ~/song.m4a` to play the song.
   - **🤩 Success, we have achieved User Story No. 1! 🎉**
1. Unmount the iPhone with `fusermount -u ~/iPhone`.

## Can we copy songs from and to iTunes with the Files app on the iPhone?

## What is ATC Services?

- GUI support is in very early development.
- USB is not supported.
