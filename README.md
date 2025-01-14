## Shellcut

#### What is this?
A collection of scripts mostly for my own use, but started as a live demo during a presentation to the Fa24 JMU CS TA Team. 
These scripts manage zsh aliases in the weirdly-specific way I happened to be organizing my aliases at the time (which does not follow even zsh standards/recommendations lol).

### What's the long term goal?
**I'm not particularly tribal about my shells...**

_Here's a poem I wrote just now about that:_
> Some days I `zsh`
>
> others I `bash`
> 
> to be shell agnostic, I'll `sh` in a flash.
> 
> But when it's _speed_
> 
> that I solely seek,
> 
> I drop them all
> 
> for a `fish` oh so sleek
> 
> \- Forrester

**So the long term goal is to have a single interface/syntax in/with which I can define my aliases that can then be used to generate files to source by each shell I use that is idiomatic for that respective shell**

**_Obviously, if you only use posix-compliant shells than this is kind of not a useful goal for you to have?_**

Other goals include:
- defining and loading alias groupings/subsets
- write the thing in Rust to have an excuse to learn rudimentary Rust
- package the thing if others also like it
- what this does for aliases but for env vars


To run as "intended" execute the following command from any directory after cloning to your machine
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
