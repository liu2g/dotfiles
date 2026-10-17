#!/usr/bin/env python3
"""Host or join a syncplay watch party over the LAN.

The host serves MEDIA_PATH over HTTP with miniserve and runs a syncplay-server;
guests stream a file from that HTTP server in a synced syncplay client.

Usage:
    watchparty.py serve
        Start miniserve and syncplay-server together, with their output
        prefixed by [miniserve] / [syncplay]. Runs until Ctrl-C, which stops
        both and exits 0: they get STOP_TIMEOUT seconds to exit on the SIGINT
        from the terminal, then SIGTERM, then SIGKILL after STOP_TIMEOUT more.
        If either one exits on its own, the other is stopped and the script
        exits 1.

    watchparty.py join FILEPATH [-- SYNCPLAY_ARGS...]
        Open FILEPATH in syncplay, connected to the host's syncplay-server.
        FILEPATH is relative to the host's MEDIA_PATH, e.g.
        "movies/Dune (2021).mkv" (it is URL-encoded for you). Anything after
        "--" is passed to syncplay, e.g. -- --name liu --room friday.

Requirements:
    Python 3.9+ (checked at startup). serve needs miniserve and
    syncplay-server on PATH; join needs syncplay.

Notes:
    SERVER_IP and the ports are constants below; edit them if the host's
    address changes.
    Run this script directly (./watchparty.py) rather than via `uv run`:
    syncplay is launched with `env python3`, and under uv that resolves to a
    Python without syncplay's dependencies (twisted).
"""

import sys

# Keep syntax in this file at 3.6 level so this check gets to run on old interpreters.
if sys.version_info < (3, 9):  # noqa: UP036
    sys.exit(f"watchparty.py requires Python 3.9+, found {sys.version.split()[0]}")

import argparse
import os
import signal
import subprocess
import threading
import time
from urllib.parse import quote

SERVER_IP = "192.168.8.224"
MINISERVER_PORT = "8000"
SYNCPLAY_PORT = "8999"
MEDIA_PATH = os.path.expanduser("~/serve/media")
STOP_TIMEOUT = 3

miniserve_cmd = [
    "miniserve",
    "--interfaces",
    SERVER_IP,
    "--port",
    MINISERVER_PORT,
    MEDIA_PATH
]

syncplay_server_cmd = [
    "syncplay-server",
    "--port",
    SYNCPLAY_PORT,
]

def syncplay_client_cmd(filepath, extra_args=()) -> list[str]:
    # syncplay treats arguments after the file as player options, so extras go first
    return [
        "syncplay",
        "--host",
        f"{SERVER_IP}:{SYNCPLAY_PORT}",
        *extra_args,
        f"http://{SERVER_IP}:{MINISERVER_PORT}/{quote(filepath.lstrip('/'))}"
    ]

def pump_output(name, proc):
    for line in proc.stdout:
        print(f"[{name}] {line}", end="", flush=True)

def wait_all(procs, timeout):
    """Wait up to timeout seconds in total; return the processes still running."""
    deadline = time.monotonic() + timeout
    running = []
    for proc in procs:
        try:
            proc.wait(timeout=max(0, deadline - time.monotonic()))
        except subprocess.TimeoutExpired:
            running.append(proc)
    return running

def stop_all(procs, interrupted):
    running = [proc for proc in procs.values() if proc.poll() is None]
    if interrupted:
        # Ctrl-C already sent SIGINT to the whole process group. Signalling again
        # while they shut down makes syncplay-server (twisted) print a traceback.
        running = wait_all(running, STOP_TIMEOUT)
    for proc in running:
        proc.terminate()
    for proc in wait_all(running, STOP_TIMEOUT):
        proc.kill()
        proc.wait()

def serve():
    commands = {
        "miniserve": (miniserve_cmd, None),
        "syncplay": (syncplay_server_cmd, {**os.environ, "PYTHONUNBUFFERED": "1"}),
    }
    procs = {}
    pumps = []
    interrupted = False
    try:
        for name, (cmd, env) in commands.items():
            procs[name] = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                errors="replace",
                env=env,
            )
            pump = threading.Thread(target=pump_output, args=(name, procs[name]), daemon=True)
            pump.start()
            pumps.append(pump)

        while True:
            for name, proc in procs.items():
                if proc.poll() is not None:
                    print(f"watchparty: {name} exited with code {proc.returncode}, stopping",
                          file=sys.stderr)
                    return 1
            time.sleep(0.2)
    except KeyboardInterrupt:
        interrupted = True
        return 0
    finally:
        signal.signal(signal.SIGINT, signal.SIG_IGN)
        stop_all(procs, interrupted)
        for pump in pumps:
            pump.join(timeout=1)

def join(filepath, extra_args):
    cmd = syncplay_client_cmd(filepath, extra_args)
    os.execvp(cmd[0], cmd)

def main():
    argv = sys.argv[1:]
    extra_args = []
    if "--" in argv:
        split = argv.index("--")
        argv, extra_args = argv[:split], argv[split + 1:]

    parser = argparse.ArgumentParser(description="Host or join a syncplay watch party.")
    subparsers = parser.add_subparsers(dest="command", required=True)
    subparsers.add_parser("serve", help="run miniserve and syncplay-server until Ctrl-C")
    join_parser = subparsers.add_parser(
        "join",
        help="open a served file in syncplay",
        usage="%(prog)s [-h] filepath [-- syncplay args...]",
    )
    join_parser.add_argument("filepath", help="path relative to the media root")
    args = parser.parse_args(argv)

    try:
        if args.command == "serve":
            if extra_args:
                parser.error("serve takes no extra arguments")
            return serve()
        join(args.filepath, extra_args)
    except FileNotFoundError as e:
        sys.exit(f"watchparty: {e.filename}: command not found")

if __name__ == "__main__":
    sys.exit(main())
