### Shellcut

Mostly for my own use, but was started as a live demo as part of a presentation to the Fa24 JMU CS Team. 

This collection of scripts manages zsh aliases

To run as intended execute the following command from any directory after cloning to your machine

`sudo cp -s <your clone's directory>/shellcut.sh /usr/local/bin/shellcut`

Then update path by adding the following to your own ~/.zshrc 
```
# add shellcut to path 
export PATH="<directory of your clone>:$PATH"
```

Then give yourself permission to execute the scripts with:
```
cd <directory of your clone>
chmod +x *.sh
```
