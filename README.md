<pre align="center">
         _    ___                                                _
        | |  / __)            _                         _       | |
   ____  _____  ____ __| |_| |__ ___  ____ _| |_  ___    ____  _____ _| |_ ____| |__  _____  ____
    |  _ \| ___ |/ ___) _  (_   __) _ \|  _ (_   _)/___)  |  _ \(____ (_   _) ___)  _ \| ___ |/ ___)
| | | | ____| |  ( (_| | | | | |_| | | | || |_|___ |  | |_| / ___ | | |( (___| | | | ____| |
|_| |_|_____)_|   \____| |_|  \___/|_| |_| \__|___/   |  __/\_____|  \__)____)_| |_|_____)_|
                   |_|

</pre>

A small and simple *unofficial* Docker image to make NerdPatching fonts easy.

### Why not use the official image?

The current release of the official image (as of 2022-03-01) is broken for me.
- I couldn't get it working properly.
- The image isn't updated very frequently.
- And the way its Dockerfile and the entrypoint is setup, it doesn't allow reusing the container (if need be).

So instead, I created a custom image that *works* and does exactly what I want, how I want it.

Always open to PRs, Issues and suggestions :)

## Usage

[Docker Hub link](https://hub.docker.com/r/icycomet/nerdfonts-patcher)

Run the container with no arguments. It will display the help message and exit.

```bash
docker run -v $(pwd)/in:/in -v $(pwd)/out:/out --name font-patcher icycomet/nerdfonts-patcher
```

If you pass in arguments, these will be directly passed on to the patching script.

```bash
docker run -v $(pwd)/in:/in -v $(pwd)/out:/out --name font-patcher icycomet/nerdfonts-patcher --complete --careful
```

You don't need to keep recreating the container if you don't need to change the bind paths.
Instead, just start the container and drop to a shell prompt.

```bash
docker start font-patcher
docker exec -it font-patcher /bin/ash
```

Now, you have access to `helper.sh` that you can pass on arguments to.

```bash
./helper.sh --complete --careful
```

Once done, stop the container with:

```bash
docker stop -t 1 font-patcher
```

- The image expects to find the to-be-patched fonts under the `/in` directory inside the container. Use a bind mount to load the fonts from the host machine.
- The image, after processing, puts the patched files inside `/out` directory in the container. Use another bind mount on this path to get the patched fonts.
- The image assumes `-h`/`--help` argument if no arguments are supplied when creating/running the container.
- If you see no output on passing the arguments, please recheck the arguments passed.

## Credits

- [Nerd Fonts](https://nerdfonts.com)
