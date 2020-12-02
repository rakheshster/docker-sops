# docker-sops

## What is this?
I wanted to try out [SOPS](https://github.com/mozilla/sops) on my Raspberry Pi and there was no ARM version available. Thought I'd Dockerize it. I have a bash function in my `.bash_profile` to then run the container. 

## Bash function example
```bash
function docker-sops { docker run -it --rm --name docker-sops -v $(pwd):/home -v $HOME/.gnupg:/root/.gnupg rakheshster/sops $@ }
```

I invoke this as `docker-sops`