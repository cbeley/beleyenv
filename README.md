# Beleyenv
**WARNING: This is a work in progress.  Feel free to follow-along.  If you no longer see this message, consider it more or less "stable".**

Beleyenv is a series of scripts to quickly bootstrap a very opinionated developer-centric environment for ChromeOS's officially supported Debian-based Linux container ([Crostini](https://chromium.googlesource.com/chromiumos/docs/+/master/containers_and_vms.md)). However, while it is primarily to bootstrap a newly created container, it is 100% idempotent.  You can re-run the script (or any of the individual ones) as many times as you want, with the only side-effect being that packages will be updated if a newer one is available.  Beleyenv was also designed to make minimal changes to the container to ensure that ChromeOS is still able to manage the container automatically.  It is possible to run alternate distributions or switch to Debian's testing or unstable channels, but it is not supported by ChromeOS and you'll likely run into problems down the road.

First and foremost, Beleyenv was created to bootstrap and maintain my personal set-up in a reproducible way.  However, the project has been designed to be easily used by others either as-is or with small modifications. Any files containing sensitive information are encrypted in this repo (for example `config.json`).  However, sample replacements or ways to disable features relying on encrypted files are provided and enabled by default.

## What Beleyenv Gets You
This is not a complete list, but includes the interesting things. Start reading from `index.js` to get the full story.

 * Automatic daily home backups via [Borg](https://borgbackup.readthedocs.io/)
      - Complete with status notifications that will show up along-side all your other chromeOS notifications!
      - [Read more about how to set this up here](#home-backups-via-borg)
 * Latest [Kitty Terminal](https://sw.kovidgoyal.net/kitty/)
     - There are no up to date debian packages for kitty, so Beleyenv has custom scripts to retrieve the latest kitty, install it globally, and ensure the icon is properly configured.
     - FYI, kitty is very fast -- much faster than the ChromeOS terminal app.
 * A comprehensive Zsh set-up, configured in an opinionated way
     - [Oh My Zsh](https://ohmyz.sh/)
     - [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
     - The best monospace font, [Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans), patched with [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) for an amazing icon-rich terminal experience.
     - `ls` is aliased to [lsd](https://github.com/Peltoche/lsd), which takes advantage of nerd font's added icons.
     - [Todo.txt-cli](https://github.com/todotxt/todo.txt-cli)
         + Powerlevel10k plugin for it is also enabled.
 * [Sublime Text](https://www.sublimetext.com/)
     - Automatic license file installation if you added it to `config.json`.
     - Also includes [Sublime Merge](https://www.sublimemerge.com/), but I'm still evaluating whether I want to purchase it or not, so not automatic license installation yet.
 * [Steam](https://store.steampowered.com/)
     - To not break my rule of making major system changes, it is installed via [flatpak](https://flathub.org/apps/details/com.valvesoftware.Steam)
     - Overall I've had good luck with flatpak and steam. Your millage may vary for some games. Installing steam directly involves making some significant system changes that may cause issues down the road for you.
 * [The Fuck](https://github.com/nvbn/thefuck): One of the most useful CLI tools ever.
 * Latest Node 12.x.x via the [NodeSource repo](https://github.com/nodesource/distributions)
     - Includes latest Yarn from the official [Yarn repo](https://classic.yarnpkg.com/en/docs/install/#debian-stable)

## Why make this public?
Apart from acting as an inspiration for setting up your own Linux environment on ChromeOS and overall just being an interesting project, I wanted to demonstrate how far Crostini has gotten. Crostini is built into ChromeOS and can be turned on with the click of a button.  It can also be destroyed and re-created just as easily. Once it's enabled, all your Linux apps show up alongside your Android and ChromeOS apps.  When opening a file, the open with dialog will show you options from your Linux environment and the application launcher shows all applications, regardless of their environment.  Also, with the inclusion of new quality of life features in ChromeOS such virtual desks, it's quickly becoming my new favorite OS for overall software development (Though, it's not quite ready to replace my day-job's macbook).  I'm also a huge fan of having a real, seamlessly integrated Linux distro I can set up my environment in, but still have a stable OS as the parent that runs great on laptops and lets me run Android apps for more casual things. I still use a macbook professionally, but I've always felt it's been more of a fight than I'd like to get my dev setup how I like, let alone keep it maintained and up to date.

## A note on performance
You should still have realistic expectations about how well Linux will run for you on ChromeOS based on the hardware you have.  You can't expect a cheap, low-powered chromebook to have stellar performance. I personally have the Galaxy Chromebook, which everything in this repo runs extremely well on.  If performance is important to you, you should consider some of the newer higher-end chromebooks with the latest generation CPU's. Also, while the Pixelbook (my previous chromebook) is still excellent, the newer generation CPU in the Galaxy Chromebook and other newer laptops completely blows it out of the water performance-wise.

## Quick Start
This will give you my opinionated set-up on your chromebook.  You'll likely want to read further down, fork this repo, then adjust it to your liking. However, it has been designed to be able to run by default without relying on any of the encrypted configuration in this repo.

**WARNING:** If you do not run this on a clean-setup, this script will **overwrite any existing configuration** that Beleyenv manages **without warning and without a backup**!

1. [Set up Linux on your Chromebook](https://support.google.com/chromebook/answer/9145439) and then launch the terminal app.
2. Run `sudo apt-get update && apt-get install git && mkdir .beleyenv && cd .beleyenv && git clone https://github.com/cbeley/beleyenv.git`
3. Run `mv sample-config.json config.json`.  Edit `config.json` in your favorite editor (nano is one option: `sudo apt-get install nano`).  You only need to update `email` and `name`. Everything else can be left alone. See [Forking & Using Beleyenv For Your Own Profit](#forking-&-using-beleyenv-for-your-own-profit) to learn how to customize Beleyenv for your own use.
4. Run `./index.sh`. Note that the script will open Chrome for you and navigate to Github's SSH Keys page.  Your SSH key should already be in your clipboard at this point.  Simply paste it in and save it if you'd like to associate your newly generate ssh key with your github account. If you don't care about doing this, you can just ignore it.
5. Kitty is faster and better than the ChromeOS terminal app.  So when it's done (You'll receive a ChromeOS notification), close the ChromeOS terminal app forever and start 'kitty' -- It'll be among your other apps.

### Running individual scripts
Feel free to cherry-pick any of the scripts under `installScripts/`. They are all idempotent and none of them should overwrite configuration (those scripts are under `configScripts/`).

## Home Backups via Borg
Beleyenv uses [Borg](https://borgbackup.readthedocs.io/) to automatically back up your home directory to Google drive by taking advantage of ChromeOS's ability to mount google drive folders within Linux. You should read about how Borg works yourself, but you can otherwise quickly get backups working with Beleyenv by doing the following:

### 1. Create & Mount a backup folder on Google Drive
Use the ChromeOS file manager to choose a folder that will be the parent folder of your Borg backup repo's folder.  You can then mount it by right clicking the folder and clicking `Share with Linux`.

### 2. Create the Borg repo in your home directory
Borg is unable to determine the available storage on mounted google drive directories (Interestingly, `df -H` is accurate, but python's `shutil`, which Borg uses, reports 0). So, we first create the repo locally, then apply a [hack to work around the free space issue](https://borgbackup.readthedocs.io/en/stable/faq.html?highlight=additional_free_space#can-i-disable-checking-for-free-disk-space).

```bash
borg init --encryption=repokey-blake2 ./borgBackupRepo
mv ./borgBackupRepo /mnt/chromeos/GoogleDrive/MyDrive/path/to/parentFolder/

# Pick a conservative number in line with what available storage
# you have in Google Drive.  You can always increase this.
# You may run into hard to fix problems if you actually don't have 
# enough space available when you do the backup.
borg config -- /mnt/chromeos/GoogleDrive/MyDrive/path/to/parentFolder/borgBackupRepo additional_free_space -50G
```

### 3. Configure Beleyenv
Update `borgRepo` to point to your Borg repo's mount point from the previous section. If you ran Beleyenv to bootstrap your system already and did not set `borgRepo`, borg setup will have been skipped automatically.  Re-run the following scripts to configure automatic backups.

```bash
# This script will prompt you for your borg password.
~/.beleyenv/beleyenv/configScripts/setup-borg-env.sh
```

After this *close* your terminal and restart it.  Powerlevel10k doesn't always react well to be re-sourced.

### 4. Perform a test backup
Your environment will now automatically be set up for easy Borg usage.  Perform a test backup.

```bash
# You will be prompted to say "yes" when warned about the
# repo being in a new location. You will never be asked again, but
# it is important you run this script manually first to answer
# that prompt.
~/.beleyenv/beleyenv/installScripts/installBorgTools/borg-home-backup.sh

# This uses a special alias beleyenv creates for you.
# You'll automatically be dropped into the backup directory.
mountBackups

# If things look good, unmount the backups (You can do this while
# still being in the backups folder.)
umountBackups
```

### 5. Install the systemd services for automatic backups
```bash
~/.beleyenv/beleyenv/installScripts/installBorgTools/index.sh
```

If all goes well, you will see a notification where all your other ChromeOS notifications are in a little bit saying your Linux backup was successful.  You'll always receive notifications when backups occur.

Things are set up so that backups occur daily. If your Linux container was shut down when backups should have otherwise occurred, they will occur the next time you log into your Linux container.

## Forking & Using Beleyenv For Your Own Profit
While I've designed beleyenv to work as-is for anyone, you likely don't want the same set-up as me. Instead, you should fork Beleyenv, read the [Core Concepts](#core-concepts), then read the [Bootstrapping a Forked Repo](#bootstrapping-a-forked-repo) section.

### Core Concepts
#### Encrypted Secrets in a Public Repo
Beleyenv uses [git-crypt](https://github.com/AGWA/git-crypt) to encrypt secrets directly in this repo (mostly) automatically. While I've done my best to make as many things public as possible, some things were too sensitive to share (mainly licenses and information more specific to my home network). You can read `.gitattributes` to find out what files in this repo are encrypted. 

If you fork this repo, there are scripts to automatically bootstrap git-crypt for you. You can then replace the encrypted files with your own encrypted files.

#### All Scripts are Idempotent
A core testament of Beleyenv is that you should never make any changes to the system directly. They should instead be represented as scripts in Beleyenv. However, re-installing your entire container just to update a package or install something new is overkill. So instead, all scripts are designed to be idempotent, or in other words, they can be run as many times as you want and will always result in the same expected state. However, if package updates are available, they *will* be updated if you re-run a script that installs a package.

#### Configs are Always Sym-Linked when Possible
You do not need to re-run any scripts to update configuration under `configs/` typically. The `configScripts/link-configs.sh` script will instead symlink configs under `configs/` to their appropriate locations. This gives you a few benefits:

1. If you share the configuration in multiple places, you simply need to `git pull` to update your configuration elsewhere.
2. If you (or some other script) makes a change to any of the managed configs, it'll be apparent via `git status`. You can then either check in the changes or revert them if it was unintentional.

#### Commit-Hooks to Protect Yourself
After bootstraping your forked repo, a commit hook will be installed that gives you the following:

 * Lints all your shells scripts with [ShellCheck](https://www.shellcheck.net/).
 * Ensures your repo has been unlocked with git-crypt to ensure you do not automatically check in sensitive information unencrypted.

### Bootstrapping a Forked Repo
First, fork Beleyenv as you normally would and then clone it anywhere locally.

#### Set up git-crypt
 1. Remove or rename `.gitattributes`. Also remove all files referenced in `.gitattributes` These files are encrypted for my use, so you'll have to replace them with your own stuff if you want to use any part of beleyenv that relied on them.
 2. Install `git-crypt` if not already installed: `sudo apt-get update && sudo apt-get install git-crypt`.
 3. `git-crypt init && git-crypt export-key ~/.beleyenv/secretKey`
 4. Add/replace any encrypted files you'd like and add them to `.gitattributes` (see git-crypt docs). At the very least, you should encrypted `config.json`.
 5. Run `git-crypt lock`.
 6. Test unlocking your repo: `git-crypt unlock ~/.beleyenv/secretKey`
 7. Export your key as text and store it in a safe place (like a password manager): `./devScripts/bin2hex.sh ~/.beleyenv/secretKey`

#### Install the Commit Hook
Run `./devScripts/install-commit-hook.sh`. If you've already bootstraped the repo for your usage and are starting on a clean container, `./bootstrap.sh` will do this for you. See the next section.

##### Restoring git-crypt from a Clean Checkout
Let's say you want to run beleyenv on a new container. Before you can run `./index.sh`, you have to restore your binary git-crypt `secretKey` and unlock the repo. This is mostly automated for you.

Simply run `./bootstrap.sh`. This will automatically install git-crypt for you, prompt you for your text-based version of your `secretKey` to convert to binary for you automatically, unlock your repo, and install the commit hook.

You can now run `./index.sh` to install everything.

#### Modifying What is Installed
##### `index.sh`
This is the primary entry-point for installing everything. Simply edit this file to your liking to add or remove things.

This file also contains trivial package installs for apt, flatpak, and node.

##### `configScripts/`
Contains scripts that primarily deal with adjusting system configuration in some way. They may depend on a script in `installScripts`, but can otherwise be run independently.

###### `configScripts/link-configs.sh`
This script manages all sym-linked configs in `configs/`. To add new configs, add them to `configs/`, then edit `link-configs.sh` to create the appropriate sym-links.

##### installScripts/
Anything that requires a non-trivial script to install goes in here.

##### devScripts/
Scripts used soley for the development of Beleyenv go here.

#### Configuring config.json
The default `sample-config.json` is, by default, set to only install things not requiring any secrets. Adjust it to your liking or even add things to it.

##### `email` & `name`
Used to configure git among possible other things.

##### `hosts`
Allows you to automatically configure your `/etc/hosts` file. It is just an array of of arrays of ip,hostname pairs. For example: `[["1.1.1.1", "someHostName"], ["2.2.2.2", "someOtherHostName"]]`.

##### `borgRepo`
See [Home Backups via Borg](#home-backups-via-borg)

##### `sublimeLicense`
Set to the properly escaped contents of a sublime license file. One example of how to do this in Javascript:

```javascript
console.log(JSON.stringify(`Your Sublime License here
will contain multiple lines.
Make sure you paste it excactly as-is
`));
```

##### `installThingsWithEncryptedDeps`
Set to `true` to enable scripts that normally do not run because they require encrypted files. Feel free to use this however you like or search the codebase for what relies on it to adjust to your liking.