# For window:
## 1.Install posh-git & oh-my-posh

### Check if posh-git is installed
Run the following command in PowerShell:
```
Get-Module -ListAvailable posh-git
```
If posh-git is not found, proceed with the installation.

### Install posh-git via PowerShell Gallery
```
Install-Module posh-git -Scope CurrentUser -Force
```
If prompted to install from an untrusted repository, type **A** (Yes to All).

### Install Oh My Posh
```
winget install JanDeDobbeleer.OhMyPosh -s winget
```

### Install other module
```
winget install junegunn.fzf
Install-Module -Name z -Scope CurrentUser -AllowClobber  -Force
Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser -Force
Install-Module PSReadLine -Force -SkipPublisherCheck -Scope CurrentUser
Install-Module -Name PSFzf -Scope CurrentUser -Force
```

## 2. Configure
Edit your PowerShell profile:
```
notepad $PROFILE
```
Add the following: [configure file](Microsoft.PowerShell_profile.ps1)

### Set Execution Policy (If Required)
If PowerShell blocks your profile script, run:
```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Restart PowerShell
Restart PowerShell or run:
```
. $PROFILE
```
Then, verify everything works:
```
git status  # posh-git should be active
oh-my-posh --version  # Verify Oh My Posh is installed
```

## 🎉 Done!
Now you have an enhanced PowerShell experience with Git integration and a beautiful prompt!
