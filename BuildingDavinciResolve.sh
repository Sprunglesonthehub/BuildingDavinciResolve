
# Cloning the project
if [ -d resolve-flatpak ]; then
 echo 'Compressing and storing your current work directory, then removing your old one. It will be stored as old.tar.xz';
 tar -cvf old.tar.xz resolve-flatpak/
 echo 'Removing old work directory';
 rm -rf resolve-flatpak/ ;
 echo 'Pulling resolve flatpak repo';
 git clone https://github.com/pobthebuilder/resolve-flatpak.git --recursive ;
else
 echo 'Pulling resolve flatpak repo';
 git clone https://github.com/pobthebuilder/resolve-flatpak.git --recursive ;
fi


## Currently freezes up with zypper. Need to test with other package managers.

# Installing Flatpak/Flatpak-Builder
#echo 'I am going to build you the latest version of resolve.'
#if [ -d resolve-flatpak ]; then
#  echo 'Not going to clone repo, you already have it.';
#  echo 'Installing dependency';
#   if [ command -v flatpak-builder &>/dev/null ]; then
#     echo 'We already have flatpak-builder';
#   else
#     echo 'We are installing Flatpak-builder'
#     if [ command -v flatpak &>/dev/null ]; then
#      echo 'Checking if flatpak-builder installed, you already have it installed.'
#     else
#        echo 'flatpak-builder is not installed, installing flatpak.'
#        case "$(lsb_release -i | cut -f 2)" in 
#            Ubuntu | ubuntu )
#              echo 'Configuring flatpak and then flatpak-builder';
#              yes | sudo apt update && yes | sudo apt install flatpak;
#              echo 'Configuring flatpak';
#              sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
#              echo 'flatpak is configured.';
#              echo 'Installing flatpak-builder';
#             yes | sudo apt install flatpak-builder;
 #             ;;
#
 #           Fedora | fedora )
#              yes | sudo dnf install flatpak;
#              echo 'Configuring flatpak';
#              sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
#              echo 'flatpak is configured.';
#              echo 'Installing flatpak-builder';
#              yes | sudo dnf install flatpak-builder;
#              ;;
#
#            OpenSUSE | Opensuse | OpenSuse | openSUSE )
#              sudo zypper up && yes | sudo zypper in flatpak;
#              echo 'Configuring flatpak';
#              sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
#              echo 'flatpak is configured.';
#              echo 'Installing flatpak-builder';
#              yes | sudo zypper in flatpak-builder;
#              ;;
#
#
 #           Arch | arch )
 #             yes | sudo pacman -Syy flatpak;
 #             echo 'Configuring flatpak';
 #             sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
 #             echo 'flatpak is configured.';
 #             echo 'Installing flatpak-builder';
 #             yes | sudo pacman -Syy flatpak-builder;
 #             ;;       
 #       esac       
 #    fi
 #  fi
#else
#  git clone https://github.com/pobthebuilder/resolve-flatpak.git --recursive ; 
#  cd resolve-flatpak/
#  echo 'Installing dependency';
#  if [ command -v flatpak-builder &>/dev/null ]; then
#    echo 'We already have flatpak-builder';
 # else
 #   echo 'We are installing Flatpak-builder'
 #    if [ command -v flatpak &>/dev/null ]; then
 #     echo 'Checking if flatpak installed, you already have it installed.'
 #    else
 #      echo 'flatpak-builder is not installed, installing flatpak-builder.'
 #      case "$(lsb_release -i | cut -f 2)" in
 #          Ubuntu | ubuntu )
 #             echo 'Configuring flatpak and then flatpak-builder';
 #             yes | sudo apt update && yes | sudo apt install flatpak;
 #             echo 'Configuring flatpak';
 #             sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
 #             echo 'flatpak is configured.';
 #             echo 'Installing flatpak-builder';
 #             yes | sudo apt install flatpak-builder;
 #             ;;
#
 #           Fedora | fedora )
 #             yes | sudo dnf install flatpak;
#            echo 'Configuring flatpak';
#              sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
 #             echo 'flatpak is configured.';
 #             echo 'Installing flatpak-builder';
 #             yes | sudo dnf install flatpak-builder;
 #             ;;
#
 #           OpenSUSE | Opensuse | OpenSuse )
 #             sudo zypper up && yes | sudo zypper in flatpak;
 #             echo 'Configuring flatpak';
 #             sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
 #             echo 'flatpak is configured.';
 #             echo 'Installing flatpak-builder';
 #             yes | sudo zypper in flatpak-builder;
  #            ;;
#
#
#            Arch | arch )
#              yes | sudo pacman -Syy flatpak;
#              echo 'Configuring flatpak';
#              sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;
#              echo 'flatpak is configured.';
#              echo 'Installing flatpak-builder';
#              yes | sudo pacman -Syy flatpak-builder;
#              ;;   
#       esac
#     fi
#  fi
#fi

# Building Resolve as a Flatpak

# Tell the user to install flatpak-builder
echo 'Install flatpak-builder!';

# Changing into resolve-flatpak
echo 'Moving to building directory';
cd resolve-flatpak/ ;

# Using user interaction to build resolve.
read -p 'Are you installing the Free or Professional version? Answer Free/Pro.' answer

if [ $answer == 'Free' ]; then
 echo 'Building the FREE VERSION of Davinci Resolve';
 flatpak-builder --force-clean --repo=repo build-dir com.blackmagic.Resolve.yaml;
 flatpak build-bundle repo resolve.flatpak com.blackmagic.Resolve;
else
 echo 'Building the PRO VERSION of Davinci Resolve';
 flatpak-builder --force-clean --repo=repo build-dir com.blackmagic.ResolveStudio.yaml
 flatpak build-bundle repo resolve.flatpak com.blackmagic.ResolveStudio
fi 

