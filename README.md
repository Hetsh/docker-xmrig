# MCServer
Super small and simple vanilla minecraft server.

## Running the server
```bash
docker run --detach --interactive --name mcserver --publish 25565:25565 hetsh/mcserver
```
`--interactive` enables passing commands to the running server (required for shutdown).

## Stopping the container
```bash
echo stop | docker attach mcserver
```
Because the minecraft server does not catch the `SIGTERM` signal that is sent by `docker stop`, we have to gracefully shut down the server by piping the `stop` command to container.

## Creating persistent storage
```bash
MP="/path/to/storage"
mkdir -p "$MP"
echo "eula=true" > "$MP/eula.txt"
chown -R 1378:1378 "$MP"
```
`1378` is the numerical id of the user running the server (see Dockerfile).
Mojang also requires you to accept their EULA. Honestly, you would just klick 'accept' anyway...
Start the server with the additional mount flag:
```bash
docker run --mount type=bind,source=/path/to/storage,target=/mcserver ...
```

## Automate startup and shutdown via systemd
The systemd unit can be found in my GitHub [repository](https://github.com/Hetsh/docker-mcserver).
```bash
systemctl enable mcserver@<port> --now
```
Individual server instances are distinguished by host-port.
By default, the systemd service assumes `/apps/mcserver/<port>` for persistent storage and `/etc/localtime` for timezone.
Since this is a personal systemd unit file, you might need to adjust some parameters to suit your setup.

## Fork Me!
This is an open project (visit [GitHub](https://github.com/Hetsh/docker-mcserver)).
Please feel free to ask questions, file an issue or contribute to it.