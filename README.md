# XMRig
Super small and easy to set up CPU mining client for Monero and many more coins.

## Running the server
```bash
docker run --detach --name xmrig hetsh/xmrig
```

## Stopping the container
```bash
docker stop xmrig
```

## Creating persistent storage
```bash
MP="/path/to/storage"
mkdir -p "$MP"
chown -R 1378:1378 "$MP"
```
`1378` is the numerical id of the user running the server (see Dockerfile).
Start the server with the additional mount flag:
```bash
docker run --mount type=bind,source=/path/to/storage,target=/xmrig ...
```

## Configuration
The client can be configured via config file.
[This Website](https://xmrig.com/wizard) helps you generate one.
Just place the `config.json` into the storage directory and you are good to go.

## Automate startup and shutdown via systemd
The systemd unit can be found in my GitHub [repository](https://github.com/Hetsh/docker-xmrig).
```bash
systemctl enable xmrig.service --now
```
By default, the systemd service assumes `/apps/xmrig` for persistent storage and `/etc/localtime` for timezone.
Since this is a personal systemd unit file, you might need to adjust some parameters to suit your setup.

## Fork Me!
This is an open project (visit [GitHub](https://github.com/Hetsh/docker-xmrig)).
Please feel free to ask questions, file an issue or contribute to it.