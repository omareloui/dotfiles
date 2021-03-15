from os import path
from sys import platform
from shutil import copyfile

from os.path import expanduser
home = expanduser("~")

def copy_here(src):
  basename = path.basename(src)
  copyfile(src, basename)


def copy_files():
  if platform == "linux":
    files_srcs = [
      f"{home}/.zshrc",
      f"{home}/.vimrc",
      f"{home}/.aliasrc",
      "/mnt/c/Users/USER/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
    ]
    for file_src in files_srcs:
      copy_here(file_src) 

  else: print("You have to be on linux to copy files.")



copy_files()
