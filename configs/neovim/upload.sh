#! /usr/bin/env bash
#Update the neovim configs.
cp -r ~/.config/nvim ./
git add nvim
echo -n "Enter the commit message for this neovim config update: "
read commitMessage
if [ ! -n "$commitMessage" ]; then
	commitMessage="Updated neovim config files"
	echo "using \"$commitMessage\" as your commit message."
fi
git commit -m "$commitMessage"
git push
echo done
