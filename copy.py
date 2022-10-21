from os import path, mkdir
from sys import platform
from shutil import rmtree, copyfile, copytree

from os.path import expanduser
HOME = expanduser("~")

files_srcs = [
  f"{HOME}/.config/nvim",
  f"{HOME}/.config/fish",
]

def copy_files():
  if platform == "linux":
    rmtree("dotfiles")
    mkdir("dotfiles")
    for file_src in files_srcs:
      copytree(file_src, f"dotfiles/{path.basename(file_src)}")

  else:
    print("You have to be on linux to copy files.")



if __name__ == "__main__":
  copy_files()
