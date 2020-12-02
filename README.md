# docker-sops

## What is this?
I wanted to try out [SOPS](https://github.com/mozilla/sops) on my Raspberry Pi and there was no ARM version available. Thought I'd Dockerize it. I have a bash function in my `.bash_profile` to then run the container. 

## Bash function example
```bash
function docker-sops { 
        docker run -it --rm --name docker-sops -v $(pwd):/home -v $HOME/.gnupg:/root/.gnupg rakheshster/sops $@ 
}
```

This pulls the image from DockerHub, calls it "docker-sops" (the name doesn't matter), mounts the current directory as "/home" in the container (so sops can work on it), mounts the ".gnupg" directory in your home folder into the container (so sops & gnupg can access your keys), and runs the container with the arguments to the function passed to it. Simple!

I invoke this as `docker-sops <whatever>`. I could have called the function `sops` but I decided to prefix it with `docker-` in case I install an ARM binary of sops later. You could call the function `sops` if you want. 