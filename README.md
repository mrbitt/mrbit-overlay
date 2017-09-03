# mrbit-overlay
Gentoo repository made by Giacomo

This is a Custom repository made by me.

Usage

First, install Layman from the official Portage tree. Must use the use-flag USE="git" at the moment of installation.

emerge layman

Then, in the section "overlays" in the /etc/layman/layman.cfg, add the following URL: https://raw.githubusercontent.com/mrbitt/mrbit-overlay/master/mrbitt-repo.xml
If you want to refresh the overlay (and all another overlays), just type:

layman -S 

layman -a mrbitt-overlay

That's all, folks!
