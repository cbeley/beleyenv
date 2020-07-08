# Beleyenv
**WARNING: This is a work in progress.  Feel free to follow-along.  If you no longer see this message, consider it more or less "stable".**

Beleyenv is a series of scripts to quickly bootstrap a very opinionated developer-centric environment for ChromeOS's officially supported Debian-based Linux container ([Crostini](https://chromium.googlesource.com/chromiumos/docs/+/master/containers_and_vms.md)). However, while it is primarily to bootstrap a newly created container, it is 100% idempotent.  You can re-run the script (or any of the individual ones) as many times as you want, with the only side-effect being that packages will be updated if a newer one is available.  Beleyenv was also designed to make minimal changes to the container to ensure that ChromeOS is still able to manage the container automatically.  It is possible to run alternate distributions or switch to Debian's testing or unstable channels, but it is not supported by ChromeOS and you'll likely run into problems down the road.

First and foremost, Beleyenv was created to bootstrap and maintain my personal set-up in a reproducible way.  However, the project has been designed to be easily used by others with only small modifications. Any files containing sensitive information are encrypted in this repo (for example `config.json`).  However, sample replacements or ways to disable features relying on encrypted files are provided.

## Why make this public?
Apart from acting as an inspiration for setting up your own Linux environment on ChromeOS and overall just being an interesting project, I wanted to demonstrate how far Crostini has gotten. Crostini is built into ChromeOS and can be turned on with the click of a button.  It can also be destroyed and re-created just as easily. Once it's enabled, all your Linux apps show up alongside your Android and ChromeOS apps.  When opening a file, the open with dialog will show you options from your Linux environment and the application launcher shows all applications, regardless of their environment.  Also, with the inclusion of new quality of life features in ChromeOS such virtual desks, it's quickly becoming my new favorite OS for overall software development.  I'm also a huge fan of having a real seamlessly integrated Linux distro I can set up my environment in, but still have a stable OS as the parent that runs great on laptops and lets me run Android apps for more casual things. I still use a macbook professionally, but I've always felt it's been more of a fight than I'd like to get my dev setup how I like, let alone keep it maintained and up to date.

### A note on performance
You should still have realistic expectations about how well Linux will run for you on ChromeOS based on the hardware you have.  You can't expect a cheap, low-powered chromebook to have stellar performance. I personally have the Galaxy Chromebook, which everything in this repo runs extremely well on.  If performance is important to you, you should consider some of the newer higher-end chromebooks with the latest generation CPU's. Also, while the Pixelbook (my previous chromebook) is still excellent, the newer generation CPU in the Galaxy Chromebook completely blows it out of the water performance-wise.

## Quick Start
This will give you my opinionated set-up on your chromebook.  You'll likely want to read further down, fork this repo, then adjust it to your liking.

WARNING: If you do not run this on a clean-setup, this script will overwrite any existing configuration that beleyenv manages without warning and without a backup!

1. [Set up Linux on your Chromebook](https://support.google.com/chromebook/answer/9145439) and then launch the terminal app.
2. Run `sudo apt-get update && apt-get install git && mkdir .beleyenv && cd .beleyenv && git clone https://github.com/cbeley/beleyenv.git`
3. Run `mv sample-config.json config.json`.  Edit `config.json` in your favorite editor (nano is one option: `sudo apt-get install nano`).  `sublimeLicense` may be left null and `iAmNotChrisBeley` should be left `true`.
4. Run `./index.sh`. Note that the script will open Chrome for you and navigate to Github's SSH Keys page.  Your SSH key should already be in your clipboard at this point.  Simply paste it in and save it if you'd like to associate your newly generate ssh key with your github account.
5. Kitty is faster and better than the ChromeOS terminal app.  So when it's done (You'll receive a ChromeOS notification), close the ChromeOS terminal app forever and start 'kitty' -- It'll be among your other apps.

### Running individual scripts
Feel free to cherry-pick any of the scripts under `installScripts/`. They are all idempotent and none of them should overwrite configuration (those scripts are under `configScripts/`).

## What Beleyenv Gets You
This is not a complete list, but includes the interesting things. Start reading from `index.js` to get the full story.

### Notable Software
 * Latest Node 12.x.x via the [NodeSource repo](https://github.com/nodesource/distributions)
     - Includes latest Yarn from the official [Yarn repo](https://classic.yarnpkg.com/en/docs/install/#debian-stable)
 * Latest [Kitty Terminal](https://sw.kovidgoyal.net/kitty/)
     - There are no up to date debian packages for kitty, so beleyenv has custom scripts to retrieve the latest kitty, install it globally, and ensure the icon is properly configured.
     - FYI, kitty is very fast -- much faster than the ChromeOS terminal app.
 * A comprehensive Zsh set-up, configured in an opinionated way
     - [Oh My Zsh](https://ohmyz.sh/)
     - [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
     - The best monospace font, [Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans) patched with [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) for an amazing icon-rich terminal experience.
     - `ls` is aliased to [lsd](https://github.com/Peltoche/lsd), which takes advantage of nerd fonts's added icons.
     - [Todo.txt-cli](https://github.com/todotxt/todo.txt-cli)
         + Powerlevel10k plugin for it is also enabled.
 * [Sublime Text](https://www.sublimetext.com/)
     - Automatic license file installation if you added it to `config.json`.
     - Also includes [Sublime Merge](https://www.sublimemerge.com/), but I'm still evaluating whether I want to purchase it or not, so not automatic license installation yet.
 * [Steam](https://store.steampowered.com/)
     - To not break my rule of making major system changes, it is installed via [flatpak](https://flathub.org/apps/details/com.valvesoftware.Steam)
 * [The Fuck](https://github.com/nvbn/thefuck): One of the most useful CLI tools ever.
