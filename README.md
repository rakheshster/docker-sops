
## Bash function example
```bash
function docker-sops { docker run -it --rm --name docker-sops -v $(pwd):/home -v $HOME/.gnupg:/root/.gnupg rakheshster/sops $@ }
```
I can then invoke this as `docker-sops`
